<%@ Page Title="" Language="C#" MasterPageFile="~/SiteGrid.Master" AutoEventWireup="true" CodeBehind="PageAccount.aspx.cs" Inherits="BTL.MobileShop.View.PageAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Style/pageAccount.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:PlaceHolder ID="PlaceHolder_SignIn" runat="server">
        <div class="signin-wrap">
            <div>

                <div>Họ và tên: </div>
                <asp:TextBox runat="server" ID="TextBox_Name" ></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rqName" ControlToValidate="TextBox_Name" ErrorMessage="Trường này không được để trống" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div>
                <div>Email: </div>
                <asp:TextBox runat="server" ID="TextBox_Email" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="Rq_Email" ControlToValidate="TextBox_Email" ErrorMessage="Trường này không được để trống" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div>
                <div>Mật khẩu: </div>
                <asp:TextBox runat="server" ID="TextBox_Pass" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="Rq_Pass" ControlToValidate="TextBox_Pass" ErrorMessage="Trường này không được để trống" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator runat="server" ID="Ct_Pass" ErrorMessage="Pass phải có 6 kí tự trở lên" OnServerValidate="Ct_Pass_ServerValidate" ControlToValidate="TextBox_Pass"></asp:CustomValidator>
            </div>
            <div>
                <div>Nhập lại mật khẩu: </div>
                <asp:TextBox runat="server" ID="TextBox_Repass" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="Rq_Repass" ControlToValidate="TextBox_Repass" ErrorMessage="Trường này không được để trống" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator runat="server" ID="Cp_Pass"  ErrorMessage="Pass nhập lại không khớp" ControlToValidate="TextBox_Repass" ControlToCompare="TextBox_Pass" Display="Dynamic"></asp:CompareValidator>
            </div>
            <div>
                <asp:Button runat="server" ID="Button_Signin" CssClass="btn-signin" Text="Đăng kí" OnClick="Button_Signin_Click"/>
            </div>
        </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder runat="server" ID="PlaceHolder_LogIn">
         <div class="login-wrap">
             <div class="state-log">
                 <asp:Label runat="server" Visible="false" ID="lbl_stateLog"></asp:Label>
             </div>
            <div>
                <div>Email: </div>
                <asp:TextBox runat="server" ID="txt_login_email" TextMode="Email"></asp:TextBox>
            </div>
            <div>
                <div>Mật khẩu: </div>
                <asp:TextBox runat="server" ID="txt_login_pass" TextMode="Password"></asp:TextBox>
            </div>
            <div>
                <asp:Button runat="server" ID="button_login" CssClass="btn-login" Text="Đăng nhập" OnClick="button_login_Click"/>
            </div>
        </div>
    </asp:PlaceHolder>
</asp:Content>
