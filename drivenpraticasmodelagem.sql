CREATE TABLE states (
	id SERIAL PRIMARY KEY NOT NULL,
	name TEXT NOT NULL
);

CREATE TABLE cities (
	id SERIAL PRIMARY KEY NOT NULL,
	name TEXT NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES states(id)
);

CREATE TABLE "customerAddresses" (
	id SERIAL PRIMARY KEY NOT NULL,
	"customerId" INTEGER NOT NULL UNIQUE REFERENCES customers(id),
	street TEXT NOT NULL,
	number VARCHAR NOT NULL,
	complement TEXT,
	"postalCode" TEXT NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES cities(id)
);

CREATE TABLE "customerPhones" ( 
	id SERIAL PRIMARY KEY NOT NULL,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	number TEXT NOT NULL,
	type VARCHAR(11) NOT NULL
);

CREATE TABLE "bankAccount" (
	id SERIAL PRIMARY KEY NOT NULL,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	"accountNumber" TEXT UNIQUE NOT NULL,
	"agency" TEXT NOT NULL,
	"openDate" DATE NOT NULL DEFAULT NOW(),
	"closeDate" DATE);

CREATE TABLE transactions (
	id SERIAL PRIMARY KEY NOT NULL,
	"bankAccountId"	INTEGER NOT NULL REFERENCES "bankAccount"(id),
	amount BIGINT NOT NULL,
	type TEXT NOT NULL,
	"time" TIME NOT NULL DEFAULT NOW(),
	description TEXT NOT NULL,
	cancelled BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE "creditCards" (
	id SERIAL PRIMARY KEY NOT NULL ,
	"bankAccountId"	INTEGER NOT NULL REFERENCES "bankAccount"(id),
	name TEXT NOT NULL,
	number TEXT NOT NULL UNIQUE,
	"securityCode" TEXT NOT NULL,
	"expirationMonth" INTEGER NOT NULL,
	"expirationYear" INTEGER NOT NULL,
	password TEXT NOT NULL,
	"limit" INTEGER 
);