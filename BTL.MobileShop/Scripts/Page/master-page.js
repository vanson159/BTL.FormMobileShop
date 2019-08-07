 
function DeleteProductOnCart(event) {
    var a = event.target.value;
     CallServer(a,"delete");
}
function HandleResultReiseCallBack(args, context) {
    debugger;
    window.location.href = args;
}
function HandleChangeAmount(productID) {
    debugger
    alert(productID);
}
function SearchProduct() {
    debugger;
    var keySearch = document.getElementsByClassName("txt-search")[0].value;
    CallServer(keySearch, "search");
}