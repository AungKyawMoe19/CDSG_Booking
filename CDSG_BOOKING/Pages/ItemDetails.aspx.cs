using System;
using System.Web.UI;

namespace CDSG_BOOKING.Pages
{
    public partial class ItemDetails : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["ItemName"] != null)
                {
                    string ItemName = Request.QueryString["ItemName"];

                    // Fetch the item details based on the ItemName
                    Item item = GetItemDetails(ItemName);

                    if (item != null)
                    {
                        DisplayItemDetails(item);
                    }
                }
            }
        }

        // Retrieve the item details from the database based on the itemId
        private Item GetItemDetails(string ItemName)
        {
            // Replace this with your actual code to fetch the item details from the database
            if (ItemName == "Toshiba")
            {
                return new Item
                {
                    Brand = "Toshiba",
                    Model = "ABC123",
                    ScreenSize = "15.6 inches",
                    Processor = "Intel Core i5",
                    RAM = 8,
                    Storage = 256,
                    ImageUrl = "../Images/Toshiba.png"
                };
            }
            else if (ItemName == "HP")
            {
                return new Item
                {
                    Brand = "HP",
                    Model = "XYZ789",
                    ScreenSize = "14 inches",
                    Processor = "Intel Core i7",
                    RAM = 16,
                    Storage = 512,
                    ImageUrl = "../Images/HP.jpeg"
                };
            }

            else if (ItemName == "Dell")
            {
                return new Item
                {
                    Brand = "DELL",
                    Model = "DEF456",
                    ScreenSize = "13.3 inches",
                    Processor = "AMD Ryzen 5",
                    RAM = 12,
                    Storage = 512,
                    ImageUrl = "../Images/DELL.jpeg"
                };
            }

            return null;
        }

        // Display the item details on the page
        // Display the item details on the page
        private void DisplayItemDetails(Item item)
        {
            string imageUrl = ResolveUrl("~/Images/") + item.ImageUrl;
            imgItem.ImageUrl = imageUrl;
            imgItem.AlternateText = item.Brand + " " + item.Model;
            lblBrand.Text = item.Brand;
            lblModel.Text = item.Model;
            lblScreenSize.Text = item.ScreenSize;
            lblProcessor.Text = item.Processor;
            lblRAM.Text = item.RAM + " GB";
            lblStorage.Text = item.Storage + " GB";
        }


    }

    // Custom class to represent an item with its details
    public class Item
    {
        public string Brand { get; set; }
        public string Model { get; set; }
        public string ScreenSize { get; set; }
        public string Processor { get; set; }
        public int RAM { get; set; }
        public int Storage { get; set; }
        public string ImageUrl { get; set; }
    }
}
