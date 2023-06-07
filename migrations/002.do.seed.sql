INSERT INTO public.couriers (id, name)
VALUES (1, 'GLS'),
       (2, 'BRT'),
       (3, 'PDB');

INSERT INTO public.products (name, weight, id, price, quantity)
VALUES ('Product1', 0.5, 1, 2.5, 23),
       ('Product2', 0.7, 2, 3, 15),
       ('Product3', 1.2, 3, 5, 21),
       ('Product4', 0.3, 4, 1.25, 45),
       ('Product5', 2.2, 5, 23, 2);


INSERT INTO public.courier_price_range (id, lower_value, upper_value, price, courier_id)
VALUES (1, 0, 0.5, 0.5, 1),
       (2, 0.5, 1, 1, 1),
       (3, 1, 1.5, 1.8, 1),
       (4, 1.5, 2, 3, 1),
       (5, 2, null, 4.5, 1),
       (6, 0, 1.5, 1, 2),
       (7, 1.5, 4, 4, 2),
       (8, 4, null, 5, 2),
       (9, 0, 0.7, 0.8, 3),
       (10, 0.7, 2.5, 1.7, 3),
       (11, 2.5, 4, 3.4, 3),
       (12, 4, null, 4.2, 3);
