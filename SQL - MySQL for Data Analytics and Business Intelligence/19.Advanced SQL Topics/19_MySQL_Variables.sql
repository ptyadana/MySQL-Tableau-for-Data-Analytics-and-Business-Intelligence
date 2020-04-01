
/*************************************************/
/*        MySQL Scope & Variables                */
/*************************************************/

/*
Scope = Visibility

There are 3 types of MySQL Variables:
	- Local Variable
    - Session Variable
    - Global Varaible
    
    
*** Local Variable: ***
- a variable that is only visible only in the BEGIN - END block in which it was created.
- Only user defined variable can be used as local variable.

	DECLARE v_my_local_variable;
    
    
*** Session Variable: ***
- a variable that exists only for the session in which we are operating.
- It is defined on our server and it lives there
- It is visible to the connection being used only.
- Both user defined and system defiend variables can be used as session variables. (BUT some system varialbes are limited only for global variables)
	
    SET @var_name = value;
    
    Example:
	SET @s_var1 = 3;
    SELECT @s_var1;
    

*** Global Variable: ***
- applies to all connections related to a specific server.

	SET GLOBAL var_name = value;   (OR)
    
    SET @@global.var_name = value;
    
    System variables are types of pre-defined Global Variables. (such as max_connections, max_join_size)
    Only system variables can be used as Global Variables.
    Example: SET @@global.max_connections = 1; (if set like that, only 1 connection can be connected to server)
*/