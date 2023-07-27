<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingItems.aspx.cs" Inherits="CDSG_BOOKING.Pages.BookingItems" EnableEventValidation="false" %>

<%@ Register TagPrefix="uc" TagName="LogoutButton" Src="~/Controls/LogoutButton.ascx" %>
<!DOCTYPE html>
<html>
<head>
    <title>Item Grid</title>
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

        .logoutButtonStyle {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        .bookButton {
            margin-left: 10px;
            margin-bottom: 10px;
            padding: 5px 10px; /* Adjust the padding values to your liking */
            font-size: 14px; /* Adjust the font size to your liking */
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">



    <script>
        function checkAllRecords(headerCheckbox) {
            var gridView = document.getElementById('<%= GridView1.ClientID %>');
            var checkboxes = gridView.getElementsByTagName('input');
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].type === 'checkbox' && checkboxes[i] !== headerCheckbox) {
                    checkboxes[i].checked = headerCheckbox.checked;
                }
            }
        }
        function showQuantityDialog() {
            $('#quantityModal').modal('show');
        }

        function saveQuantityModal() {
            var quantity = document.getElementById('txtQuantity').value;
            __doPostBack('<%= btnSaveQuantity.UniqueID %>', quantity);
        }

        function bookItems() {
            var gridView = document.getElementById('<%= GridView1.ClientID %>');
            var checkboxes = gridView.querySelectorAll('input[type="checkbox"]');
            var selectedItemIds = [];
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    var lblItemId = checkboxes[i].closest('tr').querySelector('[id*="lblItemId"]');
                    if (lblItemId) {
                        selectedItemIds.push(lblItemId.textContent || lblItemId.innerText);
                    }
                }
            }

            if (selectedItemIds.length > 0) {
                $('#quantityModal').modal('show');
            } else {
                alert("Please select at least one item.");
            }
        }

        function saveQuantity() {
            document.getElementById('<%= btnSaveQuantity.ClientID %>').click(); y.value;
        }


        function ShowBookingSuccess() {
            Swal.fire({
                icon: 'success',
                title: 'Success',
                text: 'Booking successful.',
                showConfirmButton: false,
                timer: 1500
            }).then(function () {
                location.reload(); // Optional: Reload the page after the success message is displayed
            });
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div>
            <h2>Products</h2>
            <div id="logoutButton" class="logoutButtonStyle">
                <uc:LogoutButton runat="server" ID="LogoutButton1" ValidationGroup="logout" />
            </div>

            <asp:Button ID="btnBook" runat="server" Text="Book" OnClick="btnBook_Click" CssClass="bookButton" CommandName="BookItem" CommandArgument='<%# Eval("ItemId") %>' />
            <br />

            <asp:HiddenField ID="SelectedItemId" runat="server" />

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="ItemId">
                <Columns>
                    <asp:TemplateField HeaderText="Check">
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkHeader" runat="server" onclick="checkAllRecords(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRecord" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Item ID" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblItemId" runat="server" Text='<%# Eval("ItemId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlItemName" runat="server" Text='<%# Eval("ItemName") %>' NavigateUrl='<%# "ItemDetails.aspx?ItemName=" + Eval("ItemName") %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type">
                        <ItemTemplate>
                            <asp:Label ID="lblItemType" runat="server" Text='<%# Eval("ItemType") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price">
                        <ItemTemplate>
                            <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price", "{0:C}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# ResolveUrl("~/Images/") + Eval("ItemImage") %>' Height="50" Width="50" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>

        <div id="quantityModal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Enter Quantity</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="text" id="txtQuantity" runat="server" placeholder="Quantity" class="form-control" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="saveQuantity()">Save</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <asp:Button ID="btnSaveQuantity" runat="server" Text="Save Quantity" OnClick="btnSaveQuantity_Click" Style="display: none;" />
    </form>
</body>
</html>
