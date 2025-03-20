create table Xproduto
(codproduto int not null,
descricaoproduto varchar(50) not null,
unidade char(2) not null,
preco float not null,
primary key (codproduto));

create table Xcliente
(codcliente int not null,
cliente varchar(50) not null,
cpf char(11) not null,
endereco char(30) not null,
primary key (codcliente));

create table Xtipospagamento
(codtppagamento int not null,
descricaotppagamento varchar(20) not null,
primary key (codtppagamento));

create table Xvenda
(nnf int not null,
dtvenda date not null,
codcliente int not null,
codtppagamento int not null,
vlvenda float not null,
primary key (nnf, dtvenda),
foreign key (codcliente) references Xcliente,
foreign key (codtppagamento) references Xtipospagamento);

create table Xitensvenda
(nnf int not null,
dtvenda date not null,
codproduto int not null,
qtde float not null,
primary key (nnf, dtvenda, codproduto), 
foreign key (nnf, dtvenda) references Xvenda,
foreign key (codproduto) references Xproduto);
