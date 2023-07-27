<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemDetails.aspx.cs" Inherits="CDSG_BOOKING.Pages.ItemDetails" %>

<!DOCTYPE html>
<html>
<head>
    <title>Item Details</title>
    <style>
        body {
            background-color: lightblue;
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

            .container h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            .container img {
                display: block;
                margin: 0 auto;
                width: 200px;
                height: 200px;
            }

            .container ul {
                list-style-type: none;
                padding: 0;
                margin-top: 20px;
                text-align: center; /* Center align the specifications */
            }

                .container ul li {
                    margin-bottom: 10px;
                    text-align: left; /* Left align the specifications text */
                }

                    .container ul li strong {
                        display: inline-block;
                        width: 100px;
                        font-weight: bold;
                        text-align: right; /* Right align the label text */
                        color: #555; /* Update the font color to a darker shade of gray */
                    }

        .back-button {
            text-align: center;
            margin-top: 20px;
        }

            .back-button a {
                display: inline-block;
                padding: 10px 20px;
                background-color: #4CAF50;
                color: #fff;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

                .back-button a:hover {
                    background-color: #45a049;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Product Details</h2>
            <div>
                <asp:Image ID="imgItem" runat="server" />
            </div>
            <div>
                <h3>Specifications:</h3>
                <ul>
                    <li><strong>Brand:</strong>
                        <asp:Label ID="lblBrand" runat="server" /></li>
                    <li><strong>Model:</strong>
                        <asp:Label ID="lblModel" runat="server" /></li>
                    <li><strong>Screen Size:</strong>
                        <asp:Label ID="lblScreenSize" runat="server" /></li>
                    <li><strong>Processor:</strong>
                        <asp:Label ID="lblProcessor" runat="server" /></li>
                    <li><strong>RAM:</strong>
                        <asp:Label ID="lblRAM" runat="server" /></li>
                    <li><strong>Storage:</strong>
                        <asp:Label ID="lblStorage" runat="server" /></li>
                </ul>
            </div>
            <div class="back-button">
                <a href="BookingItems.aspx">Back</a>
            </div>
        </div>
    </form>
</body>
</html>
