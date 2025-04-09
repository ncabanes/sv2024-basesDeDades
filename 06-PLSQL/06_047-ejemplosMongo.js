// Ejemplos de entornos online que se pueden usar para hacer pruebas:
// https://www.mycompiler.io/es/new/mongodb
// https://onecompiler.com/mongodb


// Se puede insertar datos de uno en uno

db.cursos.insertOne( {nombre:"Unity"} );
db.cursos.insertOne( {nombre:"Godot", horas: 20} );

// O varios a la vez, como array

db.cursos.insertMany(
[
    {nombre:"Java", horas: 30}, 
    {nombre:"Windows Forms"}
]
);

// En un entorno online, quizá sea necesario juntar estas líneas en una si no hay comillas
// db.cursos.insertMany([{nombre:"Java", horas:30}, {nombre:"Windows Forms"}]);

// Mostrar todos los datos (equivalente a SELECT *)

db.cursos.find();

// Búsqueda exacta

db.cursos.find( {nombre:"Godot" });

// Valores menores que uno dado (less than)

db.cursos.find( {horas: {$lt:25} } );

// Relación "muchos a muchos": arrays que contienen arrays
// (probable que haya redundancias)

db.cursos.insertMany([ {
    nombre:"Hibernate", 
    horas: 20,
    asistentes: 
    [
        {nombre: "José", apellidos: "Josez", direccion: "C/ Su calle, 1", tlf: "123 45 67"},
        {nombre: "Antonio", apellidos: "Antoniez", direccion: "C/ Otra calle, 2", tlf: "123 45 68"}
    ]
},
{
    _id: 100,
    nombre:"Hacking ético", 
    prerrequisitos: "Linux básico",
    asistentes: 
    [
        {nombre: "José", apellidos: "Josez", direccion: "C/ Su calle, 1", tlf: "123 45 67"},
        {nombre: "Antonio", apellidos: "Antoniez", direccion: "C/ Otra calle, 2", tlf: "123 45 68"},
        {nombre: "Andrés", apellidos: "Andrésez", direccion: "C/ Calle Tres, 3", tlf: "123 45 69"}
    ]
} ]);

// Buscar por clave primaria

db.cursos.find({_id: 100});

// Modificar un campo

db.cursos.updateOne(
    { _id: 100  },
    { $set :  { horas: 40 } }
);

// Añadir a un (sub)array

db.cursos.updateOne(
    { nombre: "Hibernate" },
    { $addToSet : 
        { asistentes : 
            {nombre: "Andrés", apellidos: "Andrésez", direccion: "C/ Calle Tres, 3", tlf: "123 45 69"} 
        }
    }
);

// Búsqueda en un (sub)array

db.cursos.find({
    asistentes: {
        $elemMatch: { nombre: "Antonio" }
    }
});
