using System;

class Ejemplo 
{
    static void Main() 
    {
        Console.WriteLine( horaBonita(216) );
    }
    
    static string horaBonita(int segundosTotales)
    {
        int minutos = segundosTotales / 60;
        int segundos = segundosTotales % 60;
        
        string respuesta = "";
        
        if (minutos < 10)
            respuesta += "0";
        respuesta += minutos;
        
        respuesta += ":";
        
        if (segundos < 10)
            respuesta += "0";
        respuesta += segundos;
        
        return respuesta;
    }
}

