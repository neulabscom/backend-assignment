# Neulabs Backend Assessment

## Requirements

Docker must be installed in the machine to be able to run the compose file.

## Constraints

The provided solution of the assessment must be written in TypeScript.

## Setup
From the root folder of the project
```
docker-compose up -d
npm run migrate
```

## Implementation Context

This assessment is a real (but simplified) operational flow that we have already implemented.

The purpose of this flow is to process realtime incoming `order` events purchased by customers.  
For each order that enters the system, it must understand if the `order` is shippable and, when it is, with  
which `courier`.

Any of the architectural and project structure choices are up to you.

## Assessment

Given the input structured as the example bellow, develop a solution that will elaborate the `order` with the  
following specs:
1. if the `order` contains _more than 3_ unique items (ignore the quantity of each item) the order must be split in  
   `n` sub-orders (called `fulfillments` from now on. Look at the example to see how a `fulfillment` is structured).
2. each generated fulfillment must contain a detail of all the products adding the `weight` and `price` that can  
   be found on the database. (assume that the `weight` is in grams and the `price` is in euro)
3. for each generated `fulfillment` we need to select the courier by applying the following rules
  - if the `fulfillment` contains a number of unique `items` (still excluding the `quantity`) _less than 3_  
    then we pick a random courier from the available courier in the database
  - otherwise we take the sum of the `weight` (this time we take `quantity` into account) of all the products,  
    and we select the courier with the lower cost (based on the `courier_price_range` table) using the total  
    calculated `weight`


## Extra:
1. store the orders and the fulfilments
2. handle the case if a product is not shippable with any courier, store the order with an error state

## Example

Given the following input:

```json  
{  
    "id": "OrderId1",  
    "customer": {  
        "id": "1",  
        "email": "nick@gmail.com",  
        "firstName": "Nome",  
        "addresses": [  
            {  
                "city": "City",  
                "apartmentNumber": 27,  
                "street": "Via Di casa",  
                "fullName": "Nome Cognome"  
            }  
        ],  
        "phoneNumber": "+39 333 008 3333",  
        "lastName": "Cognome"  
    },  
    "addressInfo": {  
    "city": "City",  
    "name": "Nome Cognome",  
    "apartmentNumber": 27,  
    "street": "Via Di casa",  
    "fullName": "Nome Cognome"  
    },  
    "lineItems": [  
        {  
        "id": "id1",  
        "name": "Prod1",  
        "qta": 5  
        },  
        {  
        "id": "id2",  
        "name": "Prod2",  
        "qta": 1  
        },  
        {  
        "id": "id3",  
        "name": "Prod3",  
        "qta": 3  
        },  
        {  
        "id": "id4",  
        "name": "Prod4",  
        "qta": 3  
        }  
    ]  
}  
```  

The expected output is the generation of 2 `fulfillments` like the following:

```json  
{  
    "id": "1",  
    "orderId": "OrderId1",  
    "customer": {  
        "id": "1",  
        "email": "nick@gmail.com",  
        "firstName": "Nome",  
        "addresses": [  
            {  
                "city": "City1",  
                "apartmentNumber": 27,  
                "street": "Via Di casa",  
                "fullName": "Nome Cognome"  
            }  
        ],  
        "phoneNumber": "+39 333 008 3333",  
        "lastName": "Cognome"  
    },  
    "shippingAddress": {  
    "city": "City1",  
    "apartmentNumber": 27,  
    "street": "Via Di casa",  
    "fullName": "Nome Cognome"  
    },  
    "products": [  
        {  
        "id": "id1",  
        "name": "Prod1",  
        "qta": 5,  
        "weight": 10,  
        "price": 10  
        },  
        {  
        "id": "id2",  
        "name": "Prod2",  
        "qta": 1,  
        "weight": 11,  
        "price": 20  
        },  
        {  
        "id": "id3",  
        "name": "Prod3",  
        "qta": 3,  
        "weight": 12,  
        "price": 30  
        }  
    ],  
    "courier": "PDB"  
}  
```  

```json  
{  
    "id": "1",  
    "orderId": "OrderId1",  
    "customer": {  
        "id": "1",  
        "email": "nick@gmail.com",  
        "firstName": "Nome",  
        "addresses": [  
            {  
                "city": "City1",  
                "apartmentNumber": 27,  
                "street": "Via Di casa",  
                "fullName": "Nome Cognome"  
            }  
        ],  
        "phoneNumber": "+39 333 008 3333",  
        "lastName": "Cognome"  
    },  
    "shippingAddress": {  
        "city": "City",  
        "apartmentNumber": 27,  
        "street": "Via Di casa",  
        "fullName": "Nome Cognome"  
    },  
    "products": [  
        {  
        "id": "id4",  
        "name": "Prod4",  
        "qta": 3,  
        "weight": 15,  
        "price": 21  
        }  
    ],  
    "courier": "BRT"  
}  
```
