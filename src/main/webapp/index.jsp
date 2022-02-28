<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@ page import ="com.ecommerce.pojo.*"%>
    <%@ page import ="com.ecommerce.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Keest Electronics | Home</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<%@ include file="components/common_cs_js.jsp"%>
</head>
<body>

<div class="page"> 

<%@ include file="components/navbar.jsp"%>
    
    <%
         String searchResult=(String)request.getAttribute("enteredText");
         String cat=request.getParameter("category"); 
         ProductDaoImp pdao=new ProductDaoImp();
         CategoryDaoImp cdao1=new CategoryDaoImp();
         List<Product> l1=null;
         List<Category> cl1=cdao1.getAllCategory();        
        
         if(cat==null)
         {
        	 cat="0";
        	 
        	 if(cat.trim().equals("0"))
             {
              	l1 =pdao.getAllProduct();
             }
         }
         
         else if(cat.equals("0"))
         {
        	 l1 =pdao.getAllProduct();
         }
         
         else
         {
        	
             int categoryId=Integer.parseInt(cat.trim());
             l1=pdao.getProductByCategory(categoryId);	 
              
         }
       
    %>

   

<section class="home" id="home">

<div class="content">

<h3> The future of technology is now! </h3>
<p> Explore the range of new technology and quality products. </p>
</div>
</section>

 <section class="menu" id="menu">
<h1 class="heading"> Features </h1>
<div class="box-container">

<div class="box">
<img src="images\fe1.png" alt="">

</div>

<div class="box">
<img src="images\fe2.png" alt="">

</div>

<div class="box">
<img src="images\fe3.png" alt="" >

</div>

<div class="box">
<img src="images\fe4.png" alt="" >


</div>

<div class="box">
<img src="images\fe5.png" alt="" >

</div>

<div class="box">
<img src="images\fe6.png" alt="">

</div>

<div class="box">
<img src="images\fe7.png" alt="" >

</div>
<div class="box">
<img src="images\fe8.png" alt="" >

</div>

</div>
</section>



<div class="text-center"><%@ include file="components/message.jsp"%></div>
<div class="container-fluid">

   <!-- show categories -->
    <div class="row">
         <div class="col-md-2 " >
             <div class="list-group mt-4">
                 <%
                     int catId=Integer.parseInt(cat);
                 %>
                 <a href="index.jsp?category=0" class="list-group-item list-group-item-action <%if(catId==0){ %> active custom-bgg<%} %>" <%if(catId==0){ %> style="border:#ff9800"<%} %> >All Categories</a>
               <%
                    for(Category c: cl1)
                    {    	
               %>      
                         <a href="index.jsp?category=<%=c.getCategoryId() %>" class="list-group-item list-group-item-action <%if(catId==c.getCategoryId()){ %> active custom-bgg<%} %>" <%if(catId==c.getCategoryId()){ %> style="border:#ff9800"<%} %>><%=c.getCategoryTitle() %></a>
               <%
                    }
               %>
               </div>
         </div>  
      
   
  
   
   <!-- ****************************************** -->

   <!-- show products -->
   
   <%
       if(searchResult==null)
       {
   %>
     
     <div class="col-md-10">
         
             <div class="row mt-4" >
                 <div class="col-md-12 admin">
                     <div class="card-columns hover">
                     
                         <%
                             String stock="Out Of Stock!"; 
                             for(Product p:l1)
                             {
                         %>
                        
                         <div class="card" >
                       
                              
                             <img src="productImages/<%=p.getProductPhoto() %>" style="max-height:100%;max-width:100%; width:auto;" class="" alt="img">
                         
                             <div class="card-body">
                                 <h5 class="card-title"><a href="product.jsp?productId=<%=p.getProductId()%>" style="text-decoration: none;color:black;"> <%=p.getProductTitle() %></a></h5>
                                 <p class="card-text"><%=Helper.get10Words(p.getProductDescription()) %></p> 
                             </div>
                             <div class="card-footer text-center" style="background-color:#6c0059">
                                 <p style="font-size:20px;color:white"><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:15px;color:white"><s>&#8377;<%=p.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:15px;color:white"><%=p.getProductDiscount() %>&#37 off</span>
                                 </p>
                                  <span class="ml-2" style="font-size:15px;color:white">Stock :</span>
                                  <span class="ml-1" style="font-size:15px;color:white"><%if(p.getProductQuantity()<1){ %><span style="color:white;"><b><%=stock%></b></span><%} else{ %><%=p.getProductQuantity()%><% } %></span>
                             </div>
                             
                         </div>
                         
                       
                         <%
                             
                             }
                         %>
                     </div>
                 </div>
             </div>
           </div> 
   
         
     <%
         } 
   
       else
       {
    	   List<Product> listOfProductFromSearch=new ProductDaoImp().getSearchedProduct(searchResult);
     %>
           <div class="col-md-10">
         
             <div class="row mt-4">
                 <div class="col-md-12">
                     <div class="card-columns">
                     
                         <%
                             String stock="Out Of Stock."; 
                             for(Product p:listOfProductFromSearch)
                             {
                         %>
                         <div class="card p-2"  >
                        
                             <img src="productImages/<%=p.getProductPhoto() %>" style="max-height:100%;max-width:100%;width:auto;" class="" alt="img">
                         
                             <div class="card-body" >
                                <a href="product.jsp?productId=<%=p.getProductId() %>" style="text-decoration: none;color:black;"> <h5 class="card-title" ><%=p.getProductTitle() %></h5></a>
                                 <p class="card-text"><%=Helper.get10Words(p.getProductDescription()) %></p> 
                             </div>
                             <div class="card-footer text-center">
                                 <p style="font-size:25px"><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:15px;color:white"><s>&#8377;<%=p.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:15px;color:white"><%=p.getProductDiscount() %>&#37 off</span>
                                 </p>
                                  <span class="ml-2" style="font-size:15px;color:white">Stock :</span>
                                  <span class="ml-1" style="font-size:15px;color:white"><%if(p.getProductQuantity()<1){ %><span style="color:white;"><b><%=stock%></b></span><%} else{ %><%=p.getProductQuantity()%><% } %></span>
                             </div>
                            
                         </div>
                         
                       
                         <%
                             
                             }
                         %>
                     </div>
                 </div>
             </div>
            
         </div>
     <%
       }
     %> 
    
         
      <!-- ******* -->
 
   
         
    </div>
 </div>
 </div>
  
  <section class="footer">
<div class="share">
<a href="" class="fa-brands fa-facebook"></a>
<a href="" class="fa-brands fa-twitter"></a>
<a href="" class="fa-brands fa-instagram"></a>
<a href="" class="fa-brands fa-linkedin"></a>
</div>



</div>
</section>
 
</body>
</html>