/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comand;

import entity.Cupon;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logic.CtrlCupon;
import util.DonaCocaException;

/**
 *
 * @author selef
 */
public class AgregarCuponComando extends Comando{

    @Override
    public String ejecutar(HttpServletRequest request, HttpServletResponse response) {
         CtrlCupon ctrlC = new CtrlCupon();
        
        boolean existeCupon = true;
        
        try {
            existeCupon = ctrlC.existeCupon(request.getParameter("codCup"));
        } catch (DonaCocaException ex) {
            request.setAttribute("ex", ex.getMessage());
            return "/ABMUsuarios.jsp";
        } catch (SQLException ex) {
            Logger.getLogger(AgregarCuponComando.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Cupon cupNuevo = new Cupon();
        
        
        cupNuevo.setCodigo(request.getParameter("codCup"));
        Boolean esActivo = (request.getParameter("activo")!=null);
        cupNuevo.setActivo(esActivo);
        cupNuevo.setPorcDescuento(Float.parseFloat(request.getParameter("porcCup")));
        
        ArrayList<Cupon> cupones = null;
        
        if(!existeCupon){
            
            try {
                ctrlC.agregarCupon(cupNuevo);
                cupones = ctrlC.obtenerCupones();
            } catch (DonaCocaException ex) {
                request.setAttribute("ex", ex.getMessage());
                return"/ABMCupones.jsp";
            } catch (SQLException ex) {
                 Logger.getLogger(AgregarCuponComando.class.getName()).log(Level.SEVERE, null, ex);
             }
            
            
            request.getSession().setAttribute("listaCupones", cupones);
            request.setAttribute("ExitoCupon", true);
        }
        else{
            request.setAttribute("cuponPorAgregar", cupNuevo);
            request.setAttribute("ExitoCupon", false);    
        }
         request.getSession().setAttribute("Scroll",true);
        return "/ABMCupones.jsp";


    }
    
}
