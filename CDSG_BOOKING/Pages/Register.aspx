<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CDSG_BOOKING.Pages.Register" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            background-image: url('../Images/Register.jpg');
            background-size: cover;
            background-position: center center;
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

            .container h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            .container label {
                display: block;
                margin-bottom: 5px;
            }

            .container input[type="text"],
            .container input[type="password"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .container input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
            }

                .container input[type="submit"]:hover {
                    background-color: #45a049;
                }

        .error-message {
            color: red;
            margin-top: 5px;
        }

        .password-toggle-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

            .password-toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .password-toggle-switch .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 24px;
            }

                .password-toggle-switch .slider:before {
                    position: absolute;
                    content: "";
                    height: 16px;
                    width: 16px;
                    left: 4px;
                    bottom: 4px;
                    background-color: white;
                    transition: .4s;
                    border-radius: 50%;
                }

            .password-toggle-switch input:checked + .slider {
                background-color: #4CAF50;
            }

                .password-toggle-switch input:checked + .slider:before {
                    transform: translateX(26px);
                }

            .password-toggle-switch .slider.round {
                border-radius: 24px;
            }

                .password-toggle-switch .slider.round:before {
                    border-radius: 50%;
                }
    </style>
    <script>
        function togglePasswordVisibility() {
            var passwordField = document.getElementById('<%= txtPassword.ClientID %>');
            var passwordToggleSwitch = document.querySelector('.password-toggle-switch input');

            if (passwordField.type === "password") {
                passwordField.type = "text";
                passwordToggleSwitch.removeAttribute('checked');
            } else {
                passwordField.type = "password";
                passwordToggleSwitch.setAttribute('checked', 'checked');
            }
        }
    </script>

</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form id="registerForm" runat="server">
            <div>
                <label for="txtFirstName">First Name:</label>
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                    ErrorMessage="First Name is required" CssClass="error-message" />
            </div>
            <div>
                <label for="txtLastName">Last Name:</label>
                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName"
                    ErrorMessage="Last Name is required" CssClass="error-message" />
            </div>
            <div>
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email is required" CssClass="error-message" />
            </div>
            <div>
                <label for="txtPhoneNo">Phone Number:</label>
                <asp:TextBox ID="txtPhoneNo" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhoneNo" runat="server" ControlToValidate="txtPhoneNo"
                    ErrorMessage="Phone Number is required" CssClass="error-message" />
            </div>
            <div>
                <label for="txtNRCNo">NRC Number:</label>
                <asp:TextBox ID="txtNRCNo" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNRCNo" runat="server" ControlToValidate="txtNRCNo"
                    ErrorMessage="NRC Number is required" CssClass="error-message" />
            </div>
            <div>
                <label for="txtAddress">Address:</label>
                <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                    ErrorMessage="Address is required" CssClass="error-message" />
            </div>
            <div>
                <label for="txtUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                    ErrorMessage="Username is required" CssClass="error-message" />
            </div>

            <div class="form-group">
                <label for="txtPassword">Password:</label>
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    <div class="input-group-append">
                        <label class="password-toggle-switch">
                            
                            <input type="checkbox" onclick="togglePasswordVisibility();">
                            <span class="slider round"></span>
                            
                            
                        </label>
                    </div>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password is required" CssClass="error-message" />

                <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password must contain at least one uppercase letter and one numeric digit"
                    ValidationExpression="^(?=.*[A-Z])(?=.*\d).+$"
                    CssClass="error-message" />
            </div>

            <div>
                <label for="txtConfirmPassword">Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Confirm Password is required" CssClass="error-message" />

                <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword" Operator="Equal" Type="String"
                    ErrorMessage="Passwords do not match" CssClass="error-message" />
            </div>

            <div>
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
                <br />
                <br />
                <a href="Login.aspx">Already have an account? Log In</a>
            </div>
        </form>
    </div>
</body>
</html>
