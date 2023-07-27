using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace CDSG_BOOKING.Pages
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Customer (firstName, lastName, email, phone_no, nrc_no, address, username, password, confirmpassword, role) " +
                    "VALUES (@firstName, @lastName, @email, @phoneNo, @nrcNo, @address, @username, @password, @confirmpassword, @role)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@firstName", txtFirstName.Text);
                    command.Parameters.AddWithValue("@lastName", txtLastName.Text);
                    command.Parameters.AddWithValue("@email", txtEmail.Text);
                    command.Parameters.AddWithValue("@phoneNo", txtPhoneNo.Text);
                    command.Parameters.AddWithValue("@nrcNo", txtNRCNo.Text);
                    command.Parameters.AddWithValue("@address", txtAddress.Text);
                    command.Parameters.AddWithValue("@username", txtUsername.Text);
                    command.Parameters.AddWithValue("@password", txtPassword.Text);
                    command.Parameters.AddWithValue("@confirmpassword", txtConfirmPassword.Text);
                    command.Parameters.AddWithValue("@role", "member");

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            // Redirect to a success page or perform any other necessary actions
            Response.Redirect("Login.aspx");
        }
    }
}
