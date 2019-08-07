<%@ Page Title="" Language="C#" MasterPageFile="~/SiteGrid.Master" AutoEventWireup="true" CodeBehind="DetailProduct.aspx.cs" Inherits="BTL.MobileShop.View.DetailProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Style/detailProduct.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-wrap">
        <asp:FormView runat="server" ID="formView_product">
            <ItemTemplate>
                <div class="d-name">
                <%# Eval("ProductName") %>
            </div>
            <div class="d-content">
                <div class="d-content-image">
                    <img src="<%# Eval("DetailImage") %>"/>
                </div>
                <div class="d-content-price">
                    <div class="content-price">
                        <span class="dis-price"><%#  DiscountPrice(Eval("Price"),Eval("Discount"))%></span><span>đ</span>
                        <span class="reg-price"><%# Eval("Price")%></span><span>đ</span>
                    </div>
                    <p class="ft-ghoh">SẢN PHẨM NHẬN GIAO HÀNG TRONG 1 GIỜ</p>
                    <div class="content-sale">
                        <p class="sale-tit">Khuyến mại đặc biệt (SL có hạn)</p>
                        <div class="sale-main">
                            <ul>
                                <li>Trả góp 0%</li>
                            </ul>
                            <ul>
                                <li>Giảm ngay 2,000,000đ (đã trừ vào giá)</li>
                            </ul>
                            <ul>
                                <li>Giảm 50% Sim Viettel khi mua kèm máy</li>
                            </ul>
                            <ul>
                                <li>Gói bảo hành mở rộng 18 tháng</li>
                            </ul>
                        </div>
                    </div>
                    <div class="content-add">
                        <div class="button-add">
                            <asp:Button runat="server" ID="Button_AddProductToCard" Text="MUA NGAY" CommandArgument='<%# Eval("ProductID")%>' OnCommand="Button_AddProductToCard_Command" />
                        </div>
                        <div class="button-modal">
                            <div>TRẢ GÓP 0%
                                <br />
                                Xét duyệt nhanh qua điện thoại</div>
                            <div>TRẢ GÓP QUA THẺ<br />
                                Visa, Master Card, JCB</div>
                        </div>
                    </div>
                </div>
                <div class="d-content-option">
                    <div>THÔNG SỐ KĨ THUẬT</div>
                    <span>Màn hình: </span><%# Eval("Display") %>
                    <br>
                    <span>Camera trước: </span><%# Eval("FrontCamera") %>
                    <br>
                    <span>Camera sau: </span><%# Eval("RearCamera") %>
                    <br>
                    <span>Ram: </span><%# Eval("RAM") %>
                    <br>
                    <span>Bộ nhớ trong: </span><%# Eval("Memory") %>
                    <br>
                    <span>CPU: </span><%# Eval("CPU") %>
                    <br>
                    <span>GPU: </span><%# Eval("GPU") %>
                    <br>
                    <span>Pin: </span><%# Eval("Battery") %>
                    <br>
                    <span>HDH: </span><%# Eval("OS") %>
                </div>
            </div>
            </ItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>