<%@ Page Title="" Language="C#" MasterPageFile="~/SiteGrid.Master" AutoEventWireup="true" CodeBehind="CartPage.aspx.cs" Inherits="BTL.MobileShop.View.CartPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Style/cartPage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="c-page">
        <div class="cart-content">
            <h2>Thông tin giỏ hàng</h2>
            <asp:Label ID="lbl_state" runat="server" Text="Bạn chưa mua sản phẩm nào" Visible="false"></asp:Label>
            <asp:ScriptManager ID="aa" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePaner_Grid" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView
                        runat="server"
                        ID="GridView_Cart"
                        AutoGenerateColumns="false"
                        Width="100%">
                        <Columns>
                            <asp:ImageField DataImageUrlField="ProductImage" HeaderText="Hình Ảnh" ItemStyle-Width="100px"></asp:ImageField>
                            <asp:BoundField DataField="ProductName" HeaderText="Tên sản phẩm" ItemStyle-CssClass="item-name" />
                            <asp:BoundField DataField="ProductPrice" HeaderText="Giá" ItemStyle-CssClass="item-price" />
                            <asp:TemplateField HeaderText="Số lượng" ItemStyle-CssClass="item-amount">
                                <ItemTemplate>
                                    <span class="up-amount" onclick="HandleChangeAmount(<%# Eval("ProductID")%>)">-</span>
                                    <input type="number" class="txt-amount" value='<%# Eval("Amount")%>' readonly/>
                                    <span class="down-amount" onclick="HandleChangeAmount( <%# Eval("ProductID")%>)">+</span> 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xóa" ItemStyle-CssClass="item-delete">
                                <ItemTemplate>
                                    <asp:Button runat="server" ID="Button_Delete" OnCommand="Button_Delete_Command" CommandArgument='<%# Eval("ProductID")%>' Text="X" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <%--<Triggers>
                            <asp:AsyncPostBackTrigger  ControlID="Button1" EventName="Command" />
                    </Triggers>--%>
            </asp:UpdatePanel>
            <asp:LinkButton runat="server" PostBackUrl="~/View/FilterPage.aspx" Text="Quay lại mua hàng"></asp:LinkButton>
            <div class="total-price"><span>Tổng tiền:    </span><asp:Label ID="lbl_totalPrice" runat="server"></asp:Label></div>
        </div>
        <div class="cart-info">
            <h2>Thông tin khách hàng</h2>
            <div class="info-name">
                <label>Họ và Tên</label>
                <asp:TextBox runat="server" ID="txt_name"></asp:TextBox>
            </div>
            <div class="info-phonenumber">
                <label>Số điện thoại</label>
                <asp:TextBox runat="server" ID="txt_phonenumber"></asp:TextBox>
            </div>
            <div class="info-email">
                <label>Email</label>
                <asp:TextBox runat="server" ID="txt_email"></asp:TextBox>
            </div>
            <div class="info-address">
                <label>Địa chỉ</label>
                <asp:TextBox runat="server" ID="txt_address"></asp:TextBox>
            </div>
            <div class="info-note">
                <label>Ghi chú</label>
                <asp:TextBox runat="server" ID="txt_note" TextMode="MultiLine"></asp:TextBox>
            </div>
            <button>Xác nhận đặt hàng</button>
        </div>
    </div>
    <script src="../Scripts/Page/master-page.js"></script>
</asp:Content>