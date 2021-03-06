/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comand;

import entity.Detalle;
import entity.Torta;
import entity.Variante;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import logic.CtrlDetalle;
import logic.CtrlTorta;
import logic.CtrlVariante;
import util.DonaCocaException;

/**
 *
 * @author selef
 */
public class EditarTortaComando extends Comando{

    @Override
    public String ejecutar(HttpServletRequest request, HttpServletResponse response) {

        CtrlTorta ct = new CtrlTorta();
        CtrlVariante cv = new CtrlVariante();
        
        Torta tortaEditada = new Torta();
        ArrayList<Variante> variantes = new ArrayList<Variante>();
        
        try {
            variantes = cv.obtenerVariantes();
        } catch (DonaCocaException ex) {
            request.setAttribute("ex", ex.getMessage());
            return "/ABMTortas.jsp";
        } catch (SQLException ex) {
            Logger.getLogger(EditarTortaComando.class.getName()).log(Level.SEVERE, null, ex);
        }
 
        tortaEditada.setId(Integer.parseInt(request.getParameter("ID")));
        tortaEditada.setNombre(request.getParameter("nomTor"));
        Boolean esActivo = (request.getParameter("activo")!=null);
        tortaEditada.setActivo(esActivo);
        
        
         Part imagen = null;
        try{
            imagen = request.getPart("imgTor");
        }
        catch  (Exception ex)
        {
            request.setAttribute("ex","Error al cargar imagen");
            return ("/ABMTortas.jsp");
        }
       
        try
        {
            if(imagen.getSize() > 0 )
            {
                /*File ruta = new File("C:\\Users\\selef\\OneDrive\\Documentos\\NetBeansProjects\\Curso Java\\JavaFinalWebSele\\web\\images\\imagenesdc");
                InputStream inputStream = imagen.getInputStream();
                String fileName =  Paths.get(imagen.getSubmittedFileName()).getFileName().toString();
                File file = new File(ruta, fileName);
                Files.copy(inputStream, file.toPath(),StandardCopyOption.REPLACE_EXISTING);
                String rutaImg = fileName; */
                
                InputStream inputStream = imagen.getInputStream();
                ServletContext servletContext = request.getServletContext();
                String absoluteDiskPath = servletContext.getRealPath("/images/imagenesdc");
                String fileName = tortaEditada.getNombre()+" Imagen "+".jpg"; // MSIE fix.
                InputStream input = imagen.getInputStream();
                           BufferedImage bi = ImageIO.read(input);
                           if(bi != null){
                            ImageIO.write(bi, "jpg", new File(absoluteDiskPath, fileName));
                           
                            }
                
                
                if(inputStream!=null){
                   // torta.setImagen(inputStream);
                    //tortaEditada.setRutaImg(rutaImg);
                    tortaEditada.setRutaImg(fileName);
                }
            }
        }
        catch (Exception ex)
        {
            request.setAttribute("ex","Error al cargar imagen");
            return ("/ABMTortas.jsp");
        }
        
        String selecc[] = request.getParameterValues("variantes1");
        for(Variante v: variantes)
        {
            for(int i=0; i<selecc.length;i++)  
            {
                if(v.getId()==Integer.parseInt(selecc[i]))
                {
                    tortaEditada.agregarVariante(v);
                }
            }
        }    
        
        
         ArrayList<Torta> tortas = new ArrayList<>();
            try
            {
                ct.actualizarTorta(tortaEditada);
                tortas = ct.obtenerTortas();          
            }
            catch(DonaCocaException ex)
            {
                request.setAttribute("ex", ex.getMessage());
                request.getSession().setAttribute("Scroll",true);
                return "/ABMTortas.jsp";
            } catch (SQLException ex) {         
            Logger.getLogger(EditarTortaComando.class.getName()).log(Level.SEVERE, null, ex);
        }
            request.getSession().setAttribute("listaTortas", tortas);
            request.getSession().setAttribute("TortaEdit", tortaEditada);
            request.getSession().setAttribute("Scroll",true);
            request.setAttribute("ExitoTorta", true);
            
            return "/ABMTortas.jsp";
    }
    
}
