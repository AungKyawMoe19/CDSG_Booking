<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CDSG_BOOKING.Pages.Login" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            background-image: url('../Images/Login.jpg');
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

            .container #lblErrorMessage {
                color : red;
            }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form id="loginForm" runat="server">
            <div>
                <label for="txtUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
            </div>
            <div>
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>
            <div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </div>
        </form>
        <br />
        <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        <br />
        <a href="Register.aspx">Don't have an account? Register</a>
    </div>
</body>
</html>
