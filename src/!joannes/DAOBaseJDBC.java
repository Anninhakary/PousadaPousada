/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author alunolab02
 */
public class DAOBaseJDBC {
    protected  static Connection conn ;
    static{
        try {
            Class.forName(Config.Nome_DRIVE);
             conn = DriverManager.getConnection(Config.DB_URL,Config.DB_LOGIN,Config.DB_SENHA);
        } catch (ClassNotFoundException ex) {
           System.out.println("FATAL: drive não encontrado.");
           System.exit(1);
        } catch (SQLException ex) {
             System.out.println("ERRO SQL : "+ ex.getMessage());
                System.exit(1);
        }
       
    }
     public static Connection abrirConexao()  {
            
        try {
            Class.forName(Config.Nome_DRIVE);
             conn = DriverManager.getConnection(Config.DB_URL,Config.DB_LOGIN,Config.DB_SENHA);
        } catch (ClassNotFoundException ex) {
           System.out.println("FATAL: drive não encontrado.");
           System.exit(1);
        } catch (SQLException ex) {
             System.out.println("ERRO SQL : "+ ex.getMessage());
                System.exit(1);
        }
        return conn;
            
            
   }
    public static void main(String[] args){
        new DAOBaseJDBC();
    }
}
