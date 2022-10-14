-- Criação do banco de daods para o cenário de E-commerce
-- drop database ecommerce;
 create database ecommerce;
 use ecommerce;
 
 -- Criar tabela Cliente
 create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique	(CPF)
);      
    
  -- Criar tabela Produto
 create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Vestimenta', 'Brinquedos','Alimentos'),
    avaliacao float default 0,
    size varchar(10)-- dimensão do produto
    -- constraint unique_cpf_client unique	(CPF)
); 

 -- Criar tabela pedido
 create table orders(
	idOrder int auto_increment,
    idOrderClient int,
    idPayment int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    CodigoRastreio varchar(10),
    StatusEntraga enum('Em processamento','Em trânsito','Saiu para entrega'),
    primary key (idOrder , idPayment),
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
); 



 -- Criar tabela estoque
  create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantity int default 0
); 

create table payments(
	idClient int ,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key (idClient, idPayment),
    constraint fk_payments_clients foreign key (idClient) references clients(idClient),
    constraint fk_payments_order foreign key (idPayment) references orders(idPayment)
);


 -- Criar tabela fornecedor
  create table supplier(
	idSupplier int auto_increment primary key,
	SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
); 

 
  -- Criar tabela vendedor
  create table seller(
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
); 


create table productSeller(
	idPseller int,
	idPproduct int,
    prodQuantity int not null,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
	idPOproduct int,
	idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
	idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct,idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

SELECT idOrderClient, COUNT (*) as Quantidade, SUM (sendValue) as ValorTotal,
FROM orders
WHERE sendValue >2000
GROUP BY idOrderClient
HAVING COUNT (orders)> 2


SELECT * 
FROM orders
INNER JOIN  clients on idClient = idOrderClient
WHERE Fname LIKE "%João%"

