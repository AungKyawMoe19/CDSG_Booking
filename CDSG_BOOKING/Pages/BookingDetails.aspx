<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingDetails.aspx.cs" Inherits="CDSG_BOOKING.Pages.BookingDetails" %>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: lightblue; /* Set the background color to light blue */
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        body {
            background-image: url('../Images/Details.jpeg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="booking-details">
            <h2>Booking Details</h2>
            <asp:Button ID="GeneratePDFButton" runat="server" Text="Generate PDF Voucher" OnClick="GeneratePDFButton_Click" Visible="false" />
            <br/><br />
            <asp:GridView ID="BookingGridView" runat="server" CssClass="booking-gridview" AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="No">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <%# Eval("ItemName") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type">
                        <ItemTemplate>
                            <%# Eval("ItemType") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <%# Eval("Quantity") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price">
                        <ItemTemplate>
                            <%# Eval("Price", "{0:C}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Price">
                        <ItemTemplate>
                            <%# Eval("TotalPrice", "{0:C}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Booking Date">
                        <ItemTemplate>
                            <%# Eval("BookingDate", "{0:MM/dd/yyyy}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
    <asp:Panel ID="PdfPanel" runat="server" Visible="false">
        <embed id="PdfViewer" runat="server" width="100px" height="500px" />
    </asp:Panel>
</body>
</html>
