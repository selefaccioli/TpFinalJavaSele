
<%@page import="entity.Variante"%>
<%@page import="entity.Parametro"%>
<%@page import="entity.Detalle"%>
<%@page import="entity.Torta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="M_Adnan">
<title>PAVSHOP - Multipurpose eCommerce HTML5 Template</title>

<!-- SLIDER REVOLUTION 4.x CSS SETTINGS -->
<link rel="stylesheet" type="text/css" href="rs-plugin/css/settings.css" media="screen" />

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="css/ionicons.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/responsive.css" rel="stylesheet">

<!-- JavaScripts -->
<script src="js/modernizr.js"></script>
<script
  src="https://code.jquery.com/jquery-3.4.0.min.js"
  integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg="
  crossorigin="anonymous"></script>

<!-- Online Fonts -->
<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Playfair+Display:400,700,900' rel='stylesheet' type='text/css'>






</head>
 <body onload="scrollDiv()">
     <!-- LOADER -->
<div id="loader">
  <div class="position-center-center">
    <div class="ldr"></div>
  </div>
</div>

<!-- Wrap -->
<div id="wrap"> 
  
  <!-- header -->
  <jsp:include page="header.jsp"/>
  
        <%!ArrayList<Torta> tortas;%>
        <%!ArrayList<Variante> variantes;%>
        <%!Parametro param;%>
        <%!Torta torta;%>
        <% if(session.getAttribute("parametros")!=null){ param = (Parametro) session.getAttribute("parametros"); }%>
        <% if(session.getAttribute("listaTortas")!=null) { tortas = (ArrayList)session.getAttribute("listaTortas");}%>
        <% if(session.getAttribute("variantes")!=null) { variantes = (ArrayList)session.getAttribute("variantes");}%>
        <% torta = (Torta)session.getAttribute("TortaEdit"); 
          //ArrayList<Detalle> detallesTor = torta.getDetalles();
            if(request.getAttribute("tortaPorAgregar")!=null)        
                torta = (Torta)request.getAttribute("tortaPorAgregar");  
                
        %>
        <div class="cuenta">
            <div class="container"> 
                <%if(request.getAttribute("ex")!=null && torta ==null ){ %>
                <div class="row">
                    <div class="alert alert-success fade in">
                        <%= request.getAttribute("ex")%>
                    </div>
                </div>
                <%}%>
                <% if(tortas!=null) { %>
                <div class="row">
                    <h2 class="title text-center">Lista de Tortas</h2> 
                    <div class="col-sm-12">
                        <div class="table-responsive" style="height:400px; overflow:auto">
                            <div class="table-striped">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Precio</th>
                                            <th>Agregar / Editar</th>
                                           
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td> - </td>
                                            <td> - </td>
                                            <td> - </td>
                                            <td> - </td>
                                            
                                            <td>
                                                <form action="CtrlMaestro" method="post">
                                                    <input type="hidden"  name="form" value="SeleccionarTortaComando"/>
                                                    <input type="hidden" name="idTortaEdit" value="0">
                                                    <input type="submit" value="+ Nuevo">
                                                </form>
                                            </td>
                                        </tr>
                                        <%for(Torta t: tortas){
                                        %>
                                        <tr>
                                            <td><%= t.getId()%></td>
                                            <td><%= t.getNombre()%></td>
                                            <td><%= t.getPrecio()%></td>
                                            <td>
                                                <form action="CtrlMaestro" method="post">
                                                    <input type="hidden"  name="form" value="SeleccionarTortaComando"/>
                                                    <input type="hidden" name="idTortaEdit" value="<%= t.getId() %>">
                                                    <input type="submit" value="Editar">
                                                </form>
                                            </td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div> 
                </div>
                <div <%if(session.getAttribute("Scroll")!=null){%> id="Edit" <%session.setAttribute("Scroll", null); }%> class="row">
                    <br/>         
                    <h2 class="title text-center"><%if(torta!=null && request.getAttribute("tortaPorAgregar")==null){%>EDITAR<%} else{%>AGREGAR<%}%> TORTA</h2>
                    <br/>
                    <form action="CtrlMaestro" method="post" enctype="multipart/form-data">  
                        <div class="col-sm-6 ">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h4 class="text-left">ID</h4>
                                </div>
                                <div class="col-sm-9">
                                    <input class="control form-control"  type="text" placeholder="ID (Autom�tico)" maxlength="15" name="ID" readonly="" value="<%if(torta!=null && request.getAttribute("tortaPorAgregar")==null )%><%=torta.getId()%>">
                                </div>
                            </div>
                           
                            <div class="row">
                                <div class="col-sm-3">
                                    <h4 class="text-left">Nombre</h4>
                                </div>
                                <div class="col-sm-9">
                                    <input type="text" class="control form-control" name="nomTor" placeholder="*"  required value="<%if(torta!=null || request.getAttribute("tortaPorAgregar")!=null)%><%=torta.getNombre()%>">
                                </div>
                            </div>
                           
                            
                           
                        </div>
                        <div class="col-sm-6 ">
                            

                            <div class="row">
                                
                                <div class="col-sm-6">
                                    <h4 class="text-left">Precio</h4>
                                    <input type="text" class="control form-control" name="pvtaTor" placeholder="* (En $)" pattern="^[0-9]+(\.[0-9]+)?$" title="Numero" required value="<%if(torta!=null || request.getAttribute("tortaPorAgregar")!=null)%><%= torta.getPrecio() %>">
                                </div>
                            </div>                        
                            <div class="row">
                                <div class="col-sm-3">
                                    <h4 class="text-left">Foto</h4>
                                </div>
                                <div class="col-sm-9">
                                    <input type="file" class="control form-control" name="imgTor">
                                </div>
                            </div>
                            
                           <div class="row">
                                <div class="col-sm-12">                                                           
                                    <label class="puntero"><input class="enLinea" type="checkbox" name="activo" value="true" <% if((torta!=null || request.getAttribute("tortaPorAgregar")!=null) && torta.isActivo()== true)%>checked<%;%>><h6 class="enLinea">Activo</h6></label>
                                </div>
                            </div>  
                            
                            <div class="row">
                                <div class="col-sm-6">
                                <h4 class="text-left">Variantes</h4>

                                  <div class="table-responsive" style="height:120px; overflow:auto;">
                                        <table class="table-striped col-lg-12">
                                            <tbody>
                                            <% for(int i=0;i<variantes.size();i++){%>
                                                <tr>
                                                    <td>
                                                        
                                                        <label class="puntero"><input class="check" type="checkbox" name="variantes1" value="<%=variantes.get(i).getId()%>" <%if((torta!=null || request.getAttribute("tortaPorAgregar")!=null) && torta.contieneVariante(variantes.get(i)))%>checked<%;%>><%= variantes.get(i).getDetalle().getNombre()  %>: &nbsp; <%= variantes.get(i).getDescripcion()  %></label>

                                                    </td>
                                                </tr>
                                                <%}%>
                                           </tbody>
                                        </table>
                                    </div> 
                                </div>
                            </div>
                            <br/>
                           
                            
                            <div class="row"> 
                                <div class="col-sm-12">
                                    <%if(request.getAttribute("ex")!=null){ %>                           
                                        <div class="alert alert-danger">
                                            <p class="text-center"><%= request.getAttribute("ex")%></p>
                                        </div>
                                    <%}%>
                                    <%if(request.getAttribute("ExitoTorta")!=null){
                                        if((Boolean)request.getAttribute("ExitoTorta")){%>
                                       <div class="alert alert-success">
                                           <p class="text-center">Torta <%if(torta==null && request.getAttribute("tortaPorAgregar")==null){ %>agregada<% }else{%>editada<%}%> con �xito.</p>        
                                        </div>
                                    <% }else if(!(Boolean)request.getAttribute("ExitoTorta")){ %>
                                        <div class="alert alert-danger ">
                                            <p class="text-center">Ya existe una torta con el mismo nombre</p>        
                                        </div>           
                                    <% }}%>
                                </div>
                            </div>
                          <input type="hidden" name="form" value="<%if(torta!=null && request.getAttribute("tortaPorAgregar")==null) {%>EditarTortaComando<%}else{%>AgregarTortaComando<%}%>">
                            <button type="submit" class="btn btn-default"><%if(torta!=null && request.getAttribute("tortaPorAgregar")==null) {%>Guardar Cambios<%}else{%>Agregar Torta<%}%></button>
                            
                            
                            
                                
                        </div>
                                
                                
                     </form>   
                            
                      
                    
                </div>
                <% }%>
            </div>
        </div>
<script src="js/jquery-1.11.3.min.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/own-menu.js"></script> 
<script src="js/jquery.lighter.js"></script> 
<script src="js/owl.carousel.min.js"></script> 

<!-- SLIDER REVOLUTION 4.x SCRIPTS  --> 
<script type="text/javascript" src="rs-plugin/js/jquery.tp.t.min.js"></script> 
<script type="text/javascript" src="rs-plugin/js/jquery.tp.min.js"></script> 
<script src="js/main.js"></script> 
<script src="js/main.js"></script>
<script src="../js/mainSele.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script>
	if( !window.jQuery ) document.write('<script src="js/jquery-3.0.0.min.js"><\/script>');
</script>
    </body>
</html>