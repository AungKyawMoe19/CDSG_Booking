using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CDSG_BOOKING.Pages
{
    public partial class BookingItems : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string customerId = Request.QueryString["customerId"];
                int CustomerId;
                if (int.TryParse(customerId, out CustomerId))
                {
                    Session["CustomerId"] = CustomerId;

                    // Bind data to the GridView
                    BindItemsGrid();
                }
                else
                {
                    // Invalid customer ID, handle the error
                }

                // Bind data to the GridView
                BindItemsGrid();
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Add any additional logic or formatting for each row if needed
            }
        }

        private void BindItemsGrid()
        {
            // Retrieve data from the Item table in your database
            var items = GetItemsFromDatabase();

            // Bind the data to the GridView control
            GridView1.DataSource = items;
            GridView1.DataBind();
        }

        private DataTable GetItemsFromDatabase()
        {
            // Replace the connection string with your actual database connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT ItemId, ItemName, ItemType, Quantity, Price, ItemImage FROM Item";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Create a DataTable to hold the retrieved data
                    DataTable dataTable = new DataTable();

                    // Open the database connection
                    connection.Open();

                    // Execute the SQL query and retrieve the data into the DataTable
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        dataTable.Load(reader);
                    }

                    return dataTable;
                }
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            // Check if any items are selected
            bool isItemSelected = false;
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox chkRecord = row.FindControl("chkRecord") as CheckBox;
                if (chkRecord.Checked)
                {
                    isItemSelected = true;

                    // Get the selected ItemId from the DataKeys collection
                    int itemId = (int)GridView1.DataKeys[row.RowIndex].Value;
                    // Store the selected item ID in a session variable or perform any other logic
                    Session["SelectedItemId"] = itemId;

                    break;
                }
            }

            if (isItemSelected)
            {
                // Show the quantity input dialog box
                ScriptManager.RegisterStartupScript(this, GetType(), "showQuantityDialog", "showQuantityDialog();", true);
            }
            else
            {
                // No items selected, display a message
                string script = "setTimeout(function() { Swal.fire({ icon: 'warning', title: 'Oops!', text: 'Please select at least one record.', showConfirmButton: true }); }, 100);";
                ScriptManager.RegisterStartupScript(this, GetType(), "SweetAlert", script, true);
            }
        }

        protected void btnSaveQuantity_Click(object sender, EventArgs e)
        {
            int itemId;
            if (int.TryParse(Session["SelectedItemId"].ToString(), out itemId))
            {
                string quantityStr = txtQuantity.Value;
                if (int.TryParse(quantityStr, out int quantity))
                {
                    int availableQuantity = GetAvailableQuantity(itemId);

                    if (quantity > availableQuantity)
                    {
                        // Invalid quantity, display an error message
                        string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'Invalid quantity. Please enter a valid number.' });";
                        ScriptManager.RegisterStartupScript(this, GetType(), "SweetAlertError", script, true);
                    }
                    else
                    {
                        // Insert the booking details into the BookingTable
                        int bookingId = InsertBooking();
                        InsertBookingDetail(bookingId, itemId, quantity);

                        // Display a success message with callback function for redirect
                        string successScript = "Swal.fire({ icon: 'success', title: 'Success', text: 'Booking successful.' }).then(function() { window.location.href = 'BookingDetails.aspx?BookingId=" + bookingId + "'; });";
                        ScriptManager.RegisterStartupScript(this, GetType(), "SweetAlertSuccess", successScript, true);
                    }
                }
                else
                {
                    // Invalid quantity, display an error message
                    string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'Invalid quantity. Please enter a valid number.' });";
                    ScriptManager.RegisterStartupScript(this, GetType(), "SweetAlertError", script, true);
                }
            }
            else
            {
                // Invalid item ID, display an error message
                string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'Invalid item ID.' });";
                ScriptManager.RegisterStartupScript(this, GetType(), "SweetAlertError", script, true);
            }
        }



        private int GetAvailableQuantity(int itemId)
        {
            // Replace the connection string with your actual database connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT Quantity FROM Item WHERE ItemId = @ItemId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ItemId", itemId);

                    // Open the database connection
                    connection.Open();

                    // Execute the SQL query and retrieve the available quantity
                    int availableQuantity = Convert.ToInt32(command.ExecuteScalar());

                    return availableQuantity;
                }
            }
        }

        private int InsertBooking()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "INSERT INTO Booking (CustomerId, BookingDate) OUTPUT INSERTED.BookingId VALUES (@CustomerId, @BookingDate)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Set the parameter values
                    command.Parameters.AddWithValue("@CustomerId", Session["CustomerId"]);
                    command.Parameters.AddWithValue("@BookingDate", DateTime.Now);

                    // Open the database connection
                    connection.Open();
                    int bookingId = (int)command.ExecuteScalar();

                    return bookingId;
                }
            }
        }

        // Insert booking details into the BookingDetail table
        private void InsertBookingDetail(int BookingId, int ItemId, int Quantity)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "INSERT INTO BookingDetail (BookingId, ItemId, Quantity) VALUES (@BookingId, @ItemId, @Quantity)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Set the parameter values
                    command.Parameters.AddWithValue("@BookingId", BookingId);
                    command.Parameters.AddWithValue("@ItemId", ItemId);
                    command.Parameters.AddWithValue("@Quantity", Quantity);

                    // Open the database connection
                    connection.Open();

                    // Execute the SQL command
                    command.ExecuteNonQuery();
                }
            }
        }

    }
}
