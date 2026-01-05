drop database if exists fabrica;
create database fabrica;
use fabrica;

create table tecnico (
id int unsigned primary key auto_increment,
nombre varchar(150) not null,
nºempleado int(10) unique not null,
fecha_incorporacion date not null,
calle varchar(100),
nºcasa int(10),
localidad varchar(100),
rango varchar(25),
salario double (10,0),
id_tecnico_formador int unsigned,
foreign key(id_tecnico_formador) references tecnico(id)
);

create table emails_tecnico (
id int unsigned primary key auto_increment,
id_tecnico int unsigned not null,
foreign key(id_tecnico) references tecnico(id),
email varchar(100)
);

create table telefonos_tecnico (
id int unsigned primary key auto_increment,
id_tecnico int unsigned not null,
foreign key(id_tecnico) references tecnico(id),
telefono varchar(20)
);

create table producto (
id int unsigned primary key auto_increment,
fragancia varchar(50) not null,
nombre varchar(20) not null,
nºproducto varchar(50),
frasco varchar(50) not null,
tapon varchar (50) not null,
etiqueta varchar(50) not null,
alarma varchar(50) not null,
caja varchar(50) not null,
fecha_fabricacion date not null
);

create table linea_de_produccion (
id int unsigned primary key auto_increment,
nºlinea varchar(20) not null,
rendimiento varchar(50),
nºorden varchar(50) not null,
producto varchar(50) not null,
cantidad int (10) not null,
tiempo_marcha time not null,
consumo varchar(10),
produccion int(10)not null,
id_producto int unsigned not null,
foreign key(id_producto) references producto(id),
id_tecnico int unsigned not null,
foreign key(id_tecnico) references tecnico(id)
);

create table maquina (
id int unsigned primary key auto_increment,
nombre varchar(20) not null,
tipo enum ('llenadora', 'etiquetadora', 'encajadora'),
modelo varchar(50) not null,
nºserie varchar(50),
producto_dia varchar(50) not null,
potencia varchar (20) not null,
tiempo_marcha time not null,
rendimiento varchar(20),
id_linea_de_produccion int unsigned not null,
foreign key(id_linea_de_produccion) references linea_de_produccion(id)
);

create table intervencion (
id int unsigned primary key auto_increment,
nºregistro varchar(20) not null,
motivo varchar(250) not null,
tipo enum ('preventivo', 'correctivo', 'mejora')  not null,
fecha_solicitud date not null,
fecha_realizacion date not null,
hora_inicio time not null,
hora_fin time not null,
id_maquina int unsigned not null,
foreign key(id_maquina) references maquina(id),
tiempo_parada time
);

create table repuesto (
id int unsigned primary key auto_increment,
nºreferencia varchar(20) not null,
nombre varchar(100) not null,
modelo varchar(150) not null,
stock int (10) not null,
precio double(10,00) not null,
estanteria varchar(10) not null,
pasillo varchar(10) not null,
gaveta varchar(50) not null
);

create table electrico (
id int unsigned primary key auto_increment,
conector varchar(20) not null,
voltaje varchar(10) not null,
amperaje varchar(10) not null,
tamaño varchar(10) not null,
normativa varchar(150),
tipo varchar(50) not null,
id_repuesto int unsigned not null,
foreign key(id_repuesto) references repuesto(id)
);

create table mecanico (
id int unsigned primary key auto_increment,
material varchar(50) not null,
metrica varchar(10) not null,
longitud varchar(10) not null,
acabado varchar(50),
normativa varchar(150),
resistencia varchar(50),
vida_util varchar(50),
tipo varchar(50) not null,
id_repuesto int unsigned not null,
foreign key(id_repuesto) references repuesto(id)
);

create table proveedor (
id int unsigned primary key auto_increment,
nombre varchar(150) not null,
nºcuenta varchar(30) unique not null,
calle varchar(100),
nºlocal int(10),
localidad varchar(100),
nºpedido varchar(25) not null
);

create table emails_proveedor (
id int unsigned primary key auto_increment,
id_proveedor int unsigned not null,
foreign key(id_proveedor) references proveedor(id),
email varchar(100)
);

create table telefonos_proveedor (
id int unsigned primary key auto_increment,
id_proveedor int unsigned not null,
foreign key(id_proveedor) references proveedor(id),
telefono varchar(20)
);

create table almacen (
id int unsigned primary key auto_increment,
nombre varchar(100) not null,
zona varchar(50) not null,
pasillo varchar(10) not null,
estanteria varchar(10) not null,
altura varchar(10) not null,
nºpallet int(10)not null,
capacidad_total int(10)not null,
tipo enum ('Materias_primas','Material_terminado', 'Residuos') not null
);

create table tecnico_realiza_intervencion (
id_tecnico int unsigned,
foreign key(id_tecnico) references tecnico(id),
id_intervencion int unsigned,
foreign key(id_intervencion) references intervencion(id),
primary key(id_tecnico, id_intervencion)
);

create table intervencion_usa_repuesto (
id_intervencion int unsigned,
foreign key(id_intervencion) references intervencion(id),
id_repuesto int unsigned,
foreign key(id_repuesto) references repuesto(id),
primary key(id_intervencion, id_repuesto),
cantidad_usada int (5) unsigned not null
);

create table proveedor_suministra_repuesto (
id_proveedor int unsigned,
foreign key(id_proveedor) references proveedor(id),
id_repuesto int unsigned,
foreign key(id_repuesto) references repuesto(id),
primary key(id_proveedor, id_repuesto)
);

create table proveedor_suministra_maquina (
id_proveedor int unsigned,
foreign key(id_proveedor) references proveedor(id),
id_maquina int unsigned,
foreign key(id_maquina) references maquina(id),
primary key(id_proveedor, id_maquina)
);

create table repuesto_pertenece_maquina (
id_repuesto int unsigned,
foreign key(id_repuesto) references repuesto(id),
id_maquina int unsigned,
foreign key(id_maquina) references maquina(id),
primary key(id_repuesto, id_maquina)
);

create table almacen_guarda_producto (
id_almacen int unsigned,
foreign key(id_almacen) references almacen(id),
id_producto int unsigned,
foreign key(id_producto) references producto(id),
primary key(id_almacen, id_producto)
);
