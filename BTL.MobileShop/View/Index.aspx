<%@ Page Title="" Language="C#" MasterPageFile="~/SiteGrid.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BTL.MobileShop.View.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Style/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="p-wrap">
        <div class="p-mean-price">
            <h1>ĐIỆN THOẠI</h1>
            <ul>
                <li>
                    <a class="filter-price" href="FilterPage.aspx?lprice=0&hprice=1000000&brandID=null" title="Dưới 1 triệu">
                        <span><img src="../Content/icon/icon-m1.jpg" /></span>
                        <p>Dưới 1 triệu</p>
                    </a>
                </li>
                <li>
                    <a class="filter-price" href="FilterPage.aspx?lprice=1000000&hprice=3000000&brandID=null" onclick="#" title="Từ 1 đến 3 triệu">
                        <span><img src="../Content/icon/icon-m2.jpg" /></span>
                        <p>Từ 1 - 3 triệu</p>
                    </a>
                </li>
                <li>
                    <a class="filter-price" href="FilterPage.aspx?lprice=3000000&hprice=6000000&brandID=null" onclick="#" title="Từ 3 đến 6 triệu">
                        <span><img src="../Content/icon/icon-m3.jpg" /></span>
                        <p>Từ 3 - 6 triệu</p>
                    </a>
                </li>
                <li>
                    <a class="filter-price" href="FilterPage.aspx?lprice=6000000&hprice=10000000&brandID=null" onclick="#" title="Từ 6 đến 10 triệu">
                        <span><img src="../Content/icon/icon-m4.jpg" /></span>
                        <p>Từ 6 - 10 triệu</p>
                    </a>
                </li>
                <li>
                    <a class="filter-price" href="FilterPage.aspx?lprice=10000000&hprice=15000000&brandID=null" onclick="#" title="Từ 10 đến 15 triệu">
                        <span> <img src="../Content/icon/icon-m5.jpg" /></span>
                        <p>Từ 10 - 15 triệu</p>
                    </a>
                </li>
                <li>
                    <a class="filter-price" href="FilterPage.aspx?lprice=15000000&hprice=1000000000&brandID=null" onclick="#" title="Trên 15 triệu">
                        <span><img src="../Content/icon/icon-m6.jpg" /></span>
                        <p>Trên 15 triệu</p>
                    </a>
                </li>
                <li>
                    <a class="filter-price" href="FilterPage.aspx?lprice=0&hprice=3000000000&brandID=null" onclick="#" title="Xem tất cả">
                        <span><i class="icon-all"></i></span>
                        <p>Xem tất cả</p>
                    </a>
                </li>
            </ul>
        </div>
        <div class="p-banner">
            <img src="../Content/image/Banner1.png" />
        </div>
        <div class="p-brand">
            <div class="brand-item">
                <a href="#" title="Apple">
                    <img src="../Content/icon/brand_apple.jpg" />
                    <p>Apple</p>
                </a>
            </div>
            <div class="brand-item">
                <a href="#" title="Samsung">
                    <img src="../Content/icon/brand_samsung.png" />
                    <p>Samsung</p>
                </a>
            </div>
            <div class="brand-item">
                <a href="#" title="Oppo">
                    <img src="../Content/icon/brand_oppo.jpg" />
                    <p>OPPO</p>
                </a>
            </div>
            <div class="brand-item">
                <a href="#" title="Huawei">
                    <img src="../Content/icon/brand_huawei.jpg" />
                    <p>Huawei</p>
                </a>
            </div >
            <div class="brand-item">
                <a href="#" title="Xiaomi"> 
                    <img src="../Content/icon/brand_xiaomi.jpg" />
                    <p>Xiaomi</p>
                </a>
            </div>
            <div class="brand-item">
                <a href="#" title="VSmart">
                    <img src="../Content/icon/brand_vin.jpg" />
                    <p>VSmart</p>
                </a>
            </div>
            <div class="brand-item">
                <a href="#" title="Nokia">
                    <img src="../Content/icon/brand_nokia.png" />
                    <p>Nokia</p>
                </a>
            </div>
        </div>
        <div class="p-prolight">
            <h2><a>ĐIỆN THOẠI HOT NHẤT</a></h2>
            <div class="prolight-grid">
                <asp:DataList runat="server" ID="dataList_hotPhone"
                    RepeatColumns=5 
                    RepeatDirection="Horizontal" 
                    RepeatLayout="Flow"
                    DataKeyField="ProductID"
                    OnItemCommand="dataList_hotPhone_ItemCommand"
                    >
                    <ItemTemplate>
                        <img src="<%# Eval("ProductImage")%>" class="product-img"/>
                        <div class="product-name"><%# Eval("ProductName") %></div>
                        <div class="product-price">
                            <span class="dis-price"><%#  DiscountPrice(Eval("Price"),Eval("Discount"))%>đ</span>
                            <span class="reg-price"><%# Eval("Price")%>đ</span>
                        </div>
                        <div class="product-link">
                            <asp:LinkButton runat="server" ID="lb_Show" CommandName="Show" >Xem Chi Tiết</asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
        <div class="p-prolight">
            <h2><a>ĐIỆN THOẠI MỚI RA MẮT</a></h2>
            <div class="prolight-grid">
               <asp:DataList runat="server" ID="dataList_newPhone"
                    RepeatColumns=5
                    RepeatDirection="Horizontal"
                    RepeatLayout="Flow"
                    DataKeyField="ProductID"
                    OnItemCommand="dataList_newPhone_ItemCommand"
                   >
                    <ItemTemplate>
                        <img src="<%# Eval("ProductImage")%>" class="product-img"/>
                        <div class="product-name"><%# Eval("ProductName") %></div>
                        <div class="product-price">
                            <span class="dis-price"><%#  DiscountPrice(Eval("Price"),Eval("Discount"))%>đ</span>
                            <span class="reg-price"><%# Eval("Price")%>đ</span>
                        </div>
                        <div class="product-link">
                            <asp:LinkButton runat="server" ID="lb_Show" CommandName="Show" >Xem Chi Tiết</asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
        <div class="p-prolight">
            <h2><a>ĐIỆN THOẠI NHIẾP ẢNH</a></h2>
            <div class="prolight-grid">
                 <asp:DataList runat="server" ID="dataList_cameraPhone"
                    RepeatColumns=5
                    RepeatDirection="Horizontal" 
                    RepeatLayout="Flow"
                    DataKeyField="ProductID"
                    OnItemCommand="dataList_cameraPhone_ItemCommand"
                     >
                     <ItemTemplate>
                        <img src="<%# Eval("ProductImage")%>" class="product-img"/>
                        <div class="product-name"><%# Eval("ProductName") %></div>
                        <div class="product-price">
                            <%--Nếu discount bằng 0 thì giá sale bằng luôn giá gốc --> xử lý js để ẩn giá gốc đi--%>
                            <span class="dis-price"><%#  DiscountPrice(Eval("Price"),Eval("Discount"))%></span>đ
                            <span class="reg-price"><%# DiscountPrice(Eval("Price"),Eval("Discount"))%>đ</span>đ
                        </div>
                         <div class="product-link">
                            <asp:LinkButton runat="server" ID="lb_Show" CommandName="Show" >Xem Chi Tiết</asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>
</asp:Content>
