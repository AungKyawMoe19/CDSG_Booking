using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace CDSG_BOOKING.Pages
{
    public partial class BookingDetails : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the booking ID from the query string or session variable
                int bookingId;
                if (int.TryParse(Request.QueryString["BookingId"], out bookingId))
                {
                    // Load and display the booking details based on the booking ID
                    LoadBookingDetails(bookingId);
                }
                else
                {
                    // Invalid booking ID, handle the error or redirect to an error page
                }
            }
        }

        private void LoadBookingDetails(int bookingId)
        {
            // Retrieve the booking details from the database based on the booking ID
            DataTable bookingDetails = GetBookingDetailsFromDatabase(bookingId);

            // Bind the booking details to the GridView
            BookingGridView.DataSource = bookingDetails;
            BookingGridView.DataBind();

            // Show the Generate PDF button
            GeneratePDFButton.Visible = true;
        }

        private DataTable GetBookingDetailsFromDatabase(int bookingId)
        {
            // Replace the connection string with your actual database connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT BD.ItemId, I.ItemName, I.ItemType, BD.Quantity, I.Price, (BD.Quantity * I.Price) AS TotalPrice, B.BookingDate " +
                   "FROM BookingDetail BD " +
                   "INNER JOIN Item I ON BD.ItemId = I.ItemId " +
                   "INNER JOIN Booking B ON BD.BookingId = B.BookingId " +
                   "WHERE BD.BookingId = @BookingId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BookingId", bookingId);

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

        protected void GeneratePDFButton_Click(object sender, EventArgs e)
        {
            // Retrieve the booking ID from the query string or session variable
            int bookingId;
            if (int.TryParse(Request.QueryString["BookingId"], out bookingId))
            {
                // Retrieve the booking details from the database based on the booking ID
                DataTable bookingDetails = GetBookingDetailsFromDatabase(bookingId);

                // Generate the PDF voucher
                byte[] pdfBytes = GeneratePDFVoucher(bookingDetails);

                // Send the PDF to the client browser for downloading
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=Voucher.pdf");
                Response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length);
                Response.End();
            }
            else
            {
                // Invalid booking ID, handle the error or redirect to an error page
            }
        }

        private byte[] GeneratePDFVoucher(DataTable bookingDetails)
        {
            // Create a new PDF document
            Document document = new Document();

            // Create a new PDF writer
            using (MemoryStream stream = new MemoryStream())
            {
                PdfWriter writer = PdfWriter.GetInstance(document, stream);

                // Open the PDF document for writing
                document.Open();

                // Create a new PDF table for the voucher
                PdfPTable table = new PdfPTable(bookingDetails.Columns.Count);
                table.WidthPercentage = 100;
                table.SpacingAfter = 10f;

                // Add table headers
                foreach (DataColumn column in bookingDetails.Columns)
                {
                    if (column.ColumnName == "ItemId")
                    {
                        table.AddCell("No"); // Display "No" instead of "ItemId"
                    }
                    else
                    {
                        table.AddCell(column.ColumnName);
                    }
                }

                // Add table data
                foreach (DataRow row in bookingDetails.Rows)
                {
                    for (int i = 0; i < bookingDetails.Columns.Count; i++)
                    {
                        if (bookingDetails.Columns[i].ColumnName == "ItemId")
                        {
                            table.AddCell((row.Table.Rows.IndexOf(row) + 1).ToString()); // Use row index + 1 as "No"
                        }
                        else
                        {
                            table.AddCell(row[i].ToString());
                        }
                    }
                }

                // Add the table to the PDF document
                document.Add(table);

                // Close the PDF document
                document.Close();

                // Return the generated PDF as a byte array
                return stream.ToArray();
            }
        }


    }
}
