-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Furnitures', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Electroincs', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Painting', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Lamps', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-06-23 23:03:26', 'Three seater sofa for Home', 'https://m.media-amazon.com/images/I/71gpCn9T2EL._SX679_.jpg', 'Three Seater Sofa', 7000.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Sofa cum bed for Home', 'https://ii1.pepperfry.com/media/catalog/product/c/h/800x400/charlie-2-seater-sofa-cum-bed-in-grey-colour-by-adorn-homez-charlie-2-seater-sofa-cum-bed-in-grey-co-zwa1d8.jpg', 'charlie sofa cum bed', 4600.00, 0, 60, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-06-23 23:03:26', 'Sofa with washable cover for Home', 'https://m.media-amazon.com/images/I/61BkzKxpShL._AC_UL480_QL65_.jpg', 'Trendy sofa with washable cover', 2500.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF004', 0, '2022-06-23 23:03:26', 'Recliner for Home', 'https://m.media-amazon.com/images/I/81qnlKvJsaL._AC_UL480_FMwebp_QL65_.jpg', 'Fabric recliner', 6000.00, 0, 12, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF005', 0, '2022-06-23 23:03:26', 'Wooden table for home', 'https://images-eu.ssl-images-amazon.com/images/I/51iK3gBNb1L._SX300_SY300_QL70_FMwebp_.jpg', 'White wooden table', 4000.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF006', 0, '2022-06-23 23:03:26', 'Shoe rack for Home', 'https://m.media-amazon.com/images/I/51MVAmBf2ZL._AC_UL480_FMwebp_QL65_.jpg', 'Shoe rack', 1000.00, 0, 22, '2022-06-23 23:03:26');


INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-06-23 23:03:26', 'Vaccum cleaner For Home', 'https://m.media-amazon.com/images/I/71uTnqZvaoL._AC_UY327_FMwebp_QL65_.jpg', 'Wet and dry vacuum cleaner', 6200.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-06-23 23:03:26', 'Electronic Kettle for Home', 'https://m.media-amazon.com/images/I/51DGcy8eBCL._AC_UY327_FMwebp_QL65_.jpg', 'Piegon Electric kettle', 500.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-06-23 23:03:26', 'Smart speakers for Home', 'https://m.media-amazon.com/images/I/61u0y9ADElL._AC_UY327_FMwebp_QL65_.jpg', 'Smart speaker with powerful bass', 1200.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS004', 1, '2022-06-23 23:03:26', 'Iron box for Home', 'https://m.media-amazon.com/images/I/81IAUPMeh2L._AC_UY327_FMwebp_QL65_.jpg', 'Philips IRON BOX', 2100.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS005', 1, '2022-06-23 23:03:26', 'Induction cooktop for Kitchen', 'https://m.media-amazon.com/images/I/81od9GbumhL._AC_UY327_FMwebp_QL65_.jpg', 'Presitige induction cooktop', 3000.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS006', 1, '2022-06-23 23:03:26', 'Oven for Home', 'https://m.media-amazon.com/images/I/710GdqOStIL._AC_UY327_FMwebp_QL65_.jpg', 'Samsung oven', 6500.00, 0, 50, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-06-23 23:03:26', 'Floral Canvas for Home decor', 'https://static.onecms.io/wp-content/uploads/sites/34/2020/11/03/3d-floral-wall-art.jpg', 'Floral canvas', 2700.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-06-23 23:03:26', 'Abstract Painting For wall', 'https://m.media-amazon.com/images/I/81K3E6T6jwL._AC_UL480_FMwebp_QL65_.jpg', 'Abstract painting', 900.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Textured Painting For wall', 'https://m.media-amazon.com/images/I/71rG4TuS-QS._AC_UL480_FMwebp_QL65_.jpg', 'Textured painting ', 400.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA004', 2, '2022-06-23 23:03:26', 'Rajasthani Painting For wall', 'https://m.media-amazon.com/images/I/81BqegtU0cL._AC_UL480_FMwebp_QL65_.jpg', 'Rajasthani wall painting ', 870.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA005', 2, '2022-06-23 23:03:26', 'Wall decor for Home', 'https://m.media-amazon.com/images/I/916mCtIkdjL._AC_UL480_FMwebp_QL65_.jpg', 'Wall décor ', 1450.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA006', 2, '2022-06-23 23:03:26', 'Panle Painting For wall', 'https://m.media-amazon.com/images/I/61a0Cp2ZXVL._AC_UL480_FMwebp_QL65_.jpg', 'Panle Painting', 3600.00, 0, 70, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-06-23 23:03:26', 'Smart moon Lamp with color change for Home', 'https://m.media-amazon.com/images/I/51hQn2ywyEL._AC_UL480_FMwebp_QL65_.jpg', 'Color changing moon lamp', 450.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-06-23 23:03:26', 'Lamp with Sunset projection for Home', 'https://m.media-amazon.com/images/I/8183XXhabxL._AC_UL480_FMwebp_QL65_.jpg', 'Sunset lamp projection', 940.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-06-23 23:03:26', 'Hanging lamp with pendant for Home', 'https://m.media-amazon.com/images/I/41tMNYyLCvL._AC_UL480_FMwebp_QL65_.jpg', 'Hanging pendant lamp', 350.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-06-23 23:03:26', 'Crystal Table lamp for Home', 'https://m.media-amazon.com/images/I/61tze7gzXDL._AC_UL480_FMwebp_QL65_.jpg', 'Crystal table lamp', 680.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF005', 3, '2022-06-23 23:03:26', 'Tripod Home lamp for Home', 'https://m.media-amazon.com/images/I/71SiUbJuQTL._AC_UL480_FMwebp_QL65_.jpg', 'Tripod home lamp', 1470.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF006', 3, '2022-06-23 23:03:26', 'Bonsai LED lamp for Home', 'https://m.media-amazon.com/images/I/71RQYEhDRyL._SX569_.jpg', 'Bonsai LED lamp', 1800.00, 0, 20, '2022-06-23 23:03:26');



------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');


CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;