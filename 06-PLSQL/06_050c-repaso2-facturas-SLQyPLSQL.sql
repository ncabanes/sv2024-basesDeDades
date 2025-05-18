create table clientes(
    codigo number(8),
    nombre varchar2(50),
    calleNum varchar2(100),
    localidad varchar2(40),
    codigoPostal varchar2(6),
    constraint pk_clientes primary key (codigo)
);

create table facturas(
    numero number(5),
    fecha date,
    codigoCliente number(8),
    constraint pk_facturas primary key (numero),
    constraint fk_facturas_clientes 
        foreign key (codigoCliente) references clientes(codigo)
);

create table lineasFacturas(
    numeroFactura number(5),
    numeroLinea number(3),
    concepto varchar2(50),
    unidades number(6),
    precioUnitario number(6,2),
    constraint pk_lineasFacturas primary key (numeroFactura, numeroLinea),
    constraint fk_lineasFacturas_facturas 
        foreign key (numeroFactura) references facturas(numero)
);

-- Datos de ejemplo

insert into clientes values(1, 'Aaron', 'Su calle', 'Su localidad', '03123');
insert into clientes values(2, 'Beatriz', 'Otra calle', 'Otra localidad', '03456');


insert into facturas values(1, 
    TO_DATE('2025,05,12', 'yyyy,mm,dd'), 1);

insert into lineasFacturas values (1, 1, 'Tazas', 10, 1.50);
insert into lineasFacturas values (1, 2, 'Bolsas', 25, 1.35);
insert into lineasFacturas values (1, 3, 
    'Plumas estilográficas', 2, 7.99);

-- ------------------------------------------

CREATE OR REPLACE PROCEDURE ImprimirFactura(
    v_numFactura IN NUMBER
)
AS
    v_registroFactura facturas % ROWTYPE;
    v_registroCliente clientes % ROWTYPE;
    importeTotal lineasFacturas.precioUnitario % TYPE := 0;
    
BEGIN
    -- Cabecera de la factura
    SELECT * INTO v_registroFactura
    FROM facturas WHERE numero = v_numFactura;
    
    dbms_output.put_line(LPAD('Numero: ' || v_registroFactura.numero, 30));
    dbms_output.put_line(LPAD('Fecha: ' || v_registroFactura.fecha, 30));
    dbms_output.put_line(''); -- Linea en blanco
    
    -- Datos del cliente
    SELECT * INTO v_registroCliente
    FROM clientes WHERE codigo = v_registroFactura.codigoCliente;
    
    dbms_output.put_line(LPAD(v_registroCliente.nombre, 20));
    dbms_output.put_line(LPAD(v_registroCliente.calleNum, 20));
    dbms_output.put_line(LPAD(v_registroCliente.localidad, 20));
    dbms_output.put_line(LPAD(v_registroCliente.codigoPostal, 20));
    dbms_output.put_line('');  -- Linea en blanco
    
    -- Lineas de la factura
    FOR v_linFac IN (SELECT * FROM lineasFacturas
        WHERE numeroFactura = v_numFactura) LOOP
        
        dbms_output.put_line( RPAD(v_linFac.concepto, 20, ' ') ||
            v_linFac.unidades || ' ' || 
            v_linFac.precioUnitario || ' ' || 
            v_linFac.unidades * v_linFac.precioUnitario 
        );
        importeTotal := importeTotal + v_linFac.unidades * v_linFac.precioUnitario;
    END LOOP;
    dbms_output.put_line('');  -- Linea en blanco
    
    -- Importe total
    dbms_output.put_line('Total: ' || importeTotal);
    
END ImprimirFactura;

BEGIN
    ImprimirFactura(1);
END;
