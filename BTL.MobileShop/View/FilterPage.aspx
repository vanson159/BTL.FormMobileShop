<%@ Page Title="" Language="C#" MasterPageFile="~/SiteGrid.Master" AutoEventWireup="true" CodeBehind="FilterPage.aspx.cs" Inherits="BTL.MobileShop.View.FilterPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Style/filterPage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="f-wrap">
      <%--  <div class="f-filter">
            <p>Bộ lọc</p>
            <div class="f-filter-brand">
                <p>Hãng sản xuất</p>
                <asp:CheckBoxList ID="CheckBoxList1" runat="server" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged">
                    <asp:ListItem Text="Samsung" Value="1"></asp:ListItem>
                    <asp:ListItem Text="iPhone" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Oppo" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Huawei" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Xiaomi" Value="5"></asp:ListItem>
                    <asp:ListItem Text="VSmart" Value="6"></asp:ListItem>
                    <asp:ListItem Text="Nokia" Value="7"></asp:ListItem>
                </asp:CheckBoxList>
            </div>

            <div class="f-filter-price">
                <p>Mức giá</p>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                    <asp:ListItem Text="Dưới 1 triệu" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Từ 1- 3 Triệu" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Từ 3 - 6 triệu" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Từ 6 - 10 triệu" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Từ 10 - 15 triệu" Value="5"></asp:ListItem>
                    <asp:ListItem Text="Trên 15 triệu" Value="6"></asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div class="f-filter-os"></div>
        </div>--%>
        <div class="f-product">
            <div class="option-rangel">
                <asp:Button runat="server" ID="Button_Tang" OnClick="Button_Tang_Click" Text="Giá tăng dần"/>
                <asp:Button runat="server" ID="Button_Giam" OnClick="Button_Giam_Click" Text="Giá giảm dần"/>
            </div>
            <asp:DataList runat="server" ID="dataList_Product"
                RepeatColumns="5"
                RepeatDirection="Horizontal"
                RepeatLayout="Table"
                DataKeyField="ProductID"
                OnItemCommand="dataList_Product_ItemCommand">
                <ItemTemplate>
                    <img src="<%# Eval("ProductImage")%>" class="product-img" />
                    <div class="product-name"><%# Eval("ProductName") %></div>
                    <div class="product-price">
                        <%--<span class="dis-price"><%#  DiscountPrice(Eval("Price"),Eval("Discount"))%></span><span>đ</span>--%>
                        <span class="reg-price"><%# Eval("Price")%></span><span>đ</span>
                    </div>
                    <div class="product-option">
                        <span>Màn hình: </span><%# Eval("Display") %>
                        <br>
                        <span>Camera: </span><%# Eval("RearCamera") %>
                        <br>
                        <span>Pin: </span><%# Eval("Battery") %>
                        <br>
                        <span>Ram: </span><%# Eval("RAM") %>
                        <br>
                        <span>CPU: </span><%# Eval("CPU") %>
                        <br>
                        <span>HDH: </span><%# Eval("OS") %>
                        <br>
                    </div>
                    <div class="product-link">
                        <asp:LinkButton runat="server" ID="lb_Show" CommandName="Show">Xem Chi Tiết</asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:DataList>
            <div class="f-product-paging">
                <asp:Button runat="server" ID="Button_Previous" OnClick="Button_Previous_Click" Text="Trang Trước" />
                <span>Trang</span>
                <asp:Label runat="server" ID="Lable_CurrentPage" Text="1"></asp:Label>
                <span>Trên</span>
                <asp:Label runat="server" ID="Lable_TotalPage" Text="1"></asp:Label>
                <asp:Button runat="server" ID="Button_Next" OnClick="Button_Next_Click" Text=" Trang Sau"/>
            </div>
        </div>
    </div>
</asp:Content>