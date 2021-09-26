package main;

import integration.database.mysql.MySqlOperations;
import org.apache.log4j.PropertyConfigurator;
import java.sql.SQLException;
import java.sql.SQLOutput;
import java.util.Scanner;

import static util.enums.Log4jValues.LOG4J_PROPERTIES_FILE_PATH;
import static util.enums.SystemProperties.USER_DIR;

public class Main {
    public static Scanner input = new Scanner(System.in);
    private static final String SERVER = "sofka-training.cpxphmd1h1ok.us-east-1.rds.amazonaws.com";
    private static final String DATA_BASE_NAME = "TeodoroCalleLara_Banco_10092021";
    private static final String USER = "sofka_training";
    private static final String PASSWORD = "BZenX643bQHw";

    private static final String SELECT_ALL_FROM_CLIENTE = String.format("select * from %s.CLIENTE", DATA_BASE_NAME);
    private static final String SELECT_ALL_FROM_EMPLEADO= String.format("select * from %s.EMPLEADO", DATA_BASE_NAME);
    private static final String CALL_SP_CLIENTES_MEDELLIN= String.format("call CLIENTES_MEDELLIN()");


    private static final MySqlOperations mySqlOperations = new MySqlOperations();


    public static void main(String[] args) throws Exception {
        PropertyConfigurator.configure(USER_DIR.getValue() + LOG4J_PROPERTIES_FILE_PATH.getValue());
        Scanner sc =new Scanner(System.in);
        login();
            boolean salir=true;
            String opcion="";

            while (salir){
                mostrarMenu();
                System.out.println();
                System.out.println("=============================================================");
                System.out.print("Digita la opcion que deseas realizar: ");
                opcion = sc.nextLine();
                opcion = validar(opcion);

                switch (opcion){
                    case "1":
                        selectAllFromCliente();
                        System.out.println();
                        break;
                    case "2":
                        selectAllFromEmpleado();
                        System.out.println();
                        break;
                    case "3":
                        callSpClientesMedellin();
                        System.out.println();
                        break;
                    case "4":
                        actualizarDatosCliente();
                        System.out.println();
                        break;
                    case "5":
                        insertarNuevoCliente();
                        System.out.println();
                        break;
                    case "6":
                        calcularDiasLaborados();
                        System.out.println();
                        break;
                    case "7":
                        eliminarCliente();
                        System.out.println();
                        break;
                    case "0":
                        salir = false;
                        break;
                }

            }


        logout();

    }

    private static void login(){
        mySqlOperations.setServer(SERVER);
        mySqlOperations.setDataBaseName(DATA_BASE_NAME);
        mySqlOperations.setUser(USER);
        mySqlOperations.setPassword(PASSWORD);
    }

    private static void selectAllFromCliente() throws SQLException {
        mySqlOperations.setSqlStatement(SELECT_ALL_FROM_CLIENTE);
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();
    }

    private static void selectAllFromEmpleado() throws SQLException {
        mySqlOperations.setSqlStatement(SELECT_ALL_FROM_EMPLEADO);
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();
    }

    private static void callSpClientesMedellin() throws SQLException {
        mySqlOperations.setSqlStatement(CALL_SP_CLIENTES_MEDELLIN);
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();
    }

    private static void insertarNuevoCliente() throws SQLException {
        System.out.println("Ingrese los datos del nuevo cliente asi: \n"
        + "1,'CARLOS','GOMEZ','HERRERA','23A',04,'MEDELLIN','2015-04-12', 914456435");
        System.out.print("DATOS: ");
        String datosNuevoUsuario = "";
        datosNuevoUsuario = input.nextLine();
        datosNuevoUsuario = "call CREAR_CLIENTE("+datosNuevoUsuario+")";
        mySqlOperations.setSqlStatement(datosNuevoUsuario);
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();
    }

    private static void calcularDiasLaborados() throws SQLException {
        System.out.println("Ingrese los datos del empleado que desea saber los días labprados asi: \n"
                + "'AAAA-MM-DD', ID_EMPLEADO");
        System.out.println("DONDE AAAA-MM-DD ES LA FECHA DE INGRESO DEL EMPLEADO");
        System.out.print("DATOS: ");
        String datosUsuario = "";
        datosUsuario = input.nextLine();
        datosUsuario = "call CALCULA_DIAS_LABORADOS("+ datosUsuario+")";
        mySqlOperations.setSqlStatement(datosUsuario);
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();
    }

    private static void actualizarDatosCliente() throws SQLException {
        System.out.println("Ingrese la nueva direccion del cliente asi: \n"
                + "'50D', 3");
        System.out.print("NUEVA DIRECCION: ");
        String datosUsuario = "";
        datosUsuario = input.nextLine();
        datosUsuario = "call ACTUALIZA_CLIENTE_DIRECCION("+ datosUsuario+")";
        mySqlOperations.setSqlStatement(datosUsuario);
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();
    }

    private static void eliminarCliente() throws SQLException {
        System.out.println("Ingrese el id del cliente que desea eliminar");
        System.out.print("idCliente: ");
        String datosUsuario = "";
        datosUsuario = input.nextLine();
        datosUsuario = "call ELIMINAR_CLIENTE("+ datosUsuario+")";
        mySqlOperations.setSqlStatement(datosUsuario);
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();
    }

    private static void logout(){
        mySqlOperations.close();
    }

    public static String validar(String opt){
        Scanner scanner = new Scanner(System.in);
        String opt_valida="1,2,3,4,5,6,7,0";
        while(!opt_valida.contains(opt) || opt.equals(",") || opt.equals("")) {
            System.out.println("La opcion no valida!");
            System.out.print("opcion: ");
            opt =scanner.nextLine();
        }
        return opt;

    }

    /**Metodo para mostrar el menú**/
    public static void mostrarMenu(){
        System.out.println("=============================================================");
        System.out.println();
        System.out.println("       1. Mostrar la informacion de los clientes\n" +
                "       2. Mostrar la informacion de los empleados\n"+
                "       3. Listar solo los clientes que viven en Medellín\n"+
                "       4. Actualizar la direccion de un cliente\n"+
                "       5. Crear un nuevo cliente\n"+
                "       6. Mostrar los días trabajados por un empleado\n"+
                "       7. Eliminar un cliente\n"+
                "       0. Salir");
    }

}
