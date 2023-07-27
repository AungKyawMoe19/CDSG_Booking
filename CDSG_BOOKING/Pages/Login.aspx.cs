using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace CDSG_BOOKING.Pages
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Customer WHERE username = @username AND password = @password";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", txtUsername.Text);
                    command.Parameters.AddWithValue("@password", txtPassword.Text);

                    connection.Open();
                    int result = (int)command.ExecuteScalar();

                    if (result == 1)
                    {
                        // Successful login, redirect to the BookingItems.aspx page with the CustomerId as a query parameter
                        string customerId = GetCustomerId(txtUsername.Text);

                        if (!string.IsNullOrEmpty(customerId))
                        {
                            string redirectUrl = "BookingItems.aspx?customerId=" + customerId;
                            Response.Redirect(redirectUrl);
                        }
                        else
                        {
                            // Error getting the CustomerId, display an error message or handle the situation
                            lblErrorMessage.Text = "Error retrieving CustomerId.";
                            lblErrorMessage.Visible = true;
                        }
                    }
                    else
                    {
                        // Invalid login, display an error message
                        lblErrorMessage.Text = "Invalid username or password.";
                        lblErrorMessage.Visible = true;
                    }
                }
            }
        }

        private string GetCustomerId(string username)
        {
            // Retrieve the CustomerId based on the provided username from your data source
            // You can use your own data access method or logic here
            // Return the CustomerId as a string

            // Example: Retrieving CustomerId from a database table
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT CustomerId FROM Customer WHERE username = @username";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", username);

                    connection.Open();
                    object result = command.ExecuteScalar();

                    if (result != null)
                    {
                        return result.ToString();
                    }
                }
            }

            return null;
        }
    }
}
