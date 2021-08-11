USE Demo1

CREATE TABLE countries
(
CountryId int primary key identity(1,1),
CountryName varchar(50) not null CONSTRAINT chklocation CHECK(Countryname IN('Italy','India','China')),
RegionId int not null,
CONSTRAINT unique_columns UNIQUE(CountryId,RegionId )
)


