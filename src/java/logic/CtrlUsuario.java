
package logic;

import data.DataUsuarios;
import entity.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.DonaCocaException;

/**
 *
 * @author selef
 */
public class CtrlUsuario {
    DataUsuarios du = new DataUsuarios();
    
     public Usuario obtenerUsuario(String usuario,String password)throws DonaCocaException, SQLException{
         return du.obtenerUsuario(usuario, password);
     }
      public Usuario obtenerUsuario(int idUsuario)throws DonaCocaException, SQLException{
        return du.obtenerUsuario(idUsuario);
    }
    
     
     public boolean existeUsuario(String nombreUsuario) throws DonaCocaException, SQLException{
         return du.existeUsuario(nombreUsuario);
     }
     
     public ArrayList<Usuario> buscarUsuarios(Usuario usu) throws DonaCocaException, SQLException{
         return du.buscarUsuarios(usu);
     }
    
     public ArrayList<Usuario> obtenerUsuarios() throws DonaCocaException, SQLException{
         return du.obtenerUsuarios();
     }
     
     public void editarUsuario(Usuario usu) throws DonaCocaException, SQLException{
         du.editarUsuario(usu);
     }
     
     public void registrarUsuario(Usuario usu)throws DonaCocaException, SQLException{
         du.registrarUsuario(usu);
     }
     
     public void eliminarUsuario(Usuario usu) throws DonaCocaException, SQLException{
         du.editarUsuario(usu);
     }
     
     
}
