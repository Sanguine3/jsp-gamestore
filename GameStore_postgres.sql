-- Create database
CREATE DATABASE gamestore;

-- Connect to database
\c gamestore;

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create schema
CREATE SCHEMA IF NOT EXISTS game_shop;

-- Set search path
SET search_path TO game_shop, public;

-- Create User roles for security
CREATE TABLE user_role (
    id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Account table with security improvements
CREATE TABLE account (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    pass VARCHAR(255) NOT NULL,  -- Store hashed passwords, never plaintext
    email VARCHAR(255) UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    role_id INT REFERENCES user_role(id),
    is_active BOOLEAN DEFAULT true,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add index for account lookups
CREATE INDEX idx_account_username ON account(username);
CREATE INDEX idx_account_email ON account(email);

-- Create Publisher table
CREATE TABLE publisher (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    website VARCHAR(255),
    founded_year INT,
    description TEXT,
    logo_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Developer table
CREATE TABLE developer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    website VARCHAR(255),
    founded_year INT,
    description TEXT,
    logo_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Category table with timestamps
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon_url VARCHAR(255),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Platform table
CREATE TABLE platform (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    abbreviation VARCHAR(10),
    manufacturer VARCHAR(100),
    release_year INT,
    logo_url VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Product table with more detailed fields
CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    sku VARCHAR(50) UNIQUE,
    image_url TEXT,
    cover_image_url TEXT,
    trailer_url TEXT,
    price DECIMAL(10, 2) NOT NULL,
    sale_price DECIMAL(10, 2),
    description TEXT,
    publisher_id INT REFERENCES publisher(id),
    developer_id INT REFERENCES developer(id),
    category_id INT REFERENCES category(id),
    release_date DATE,
    age_rating VARCHAR(10),
    rating DECIMAL(3, 2) CHECK (rating >= 0 AND rating <= 5),
    stock_quantity INT DEFAULT 0,
    is_digital BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    views_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add product indexes for better performance
CREATE INDEX idx_product_name ON product(name);
CREATE INDEX idx_product_category ON product(category_id);
CREATE INDEX idx_product_release_date ON product(release_date);
CREATE INDEX idx_product_price ON product(price);

-- Create product_platform junction table for many-to-many relationship
CREATE TABLE product_platform (
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    platform_id INT REFERENCES platform(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, platform_id)
);

-- Create product_image table for multiple images per product
CREATE TABLE product_image (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    alt_text VARCHAR(255),
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create product_tag table for tagging products
CREATE TABLE tag (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create product_tag junction table
CREATE TABLE product_tag (
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    tag_id INT REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, tag_id)
);

-- Create shopping cart table
CREATE TABLE cart (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    account_id INT REFERENCES account(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create cart item table
CREATE TABLE cart_item (
    id SERIAL PRIMARY KEY,
    cart_id UUID REFERENCES cart(id) ON DELETE CASCADE,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create order status table
CREATE TABLE order_status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    display_order INT DEFAULT 0
);

-- Create payment method table
CREATE TABLE payment_method (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT true
);

-- Create address table
CREATE TABLE address (
    id SERIAL PRIMARY KEY,
    account_id INT REFERENCES account(id) ON DELETE CASCADE,
    address_type VARCHAR(20) NOT NULL,  -- 'billing' or 'shipping'
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    is_default BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Orders table with more details
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    account_id INT REFERENCES account(id) ON DELETE SET NULL,
    status_id INT REFERENCES order_status(id),
    billing_address_id INT REFERENCES address(id),
    shipping_address_id INT REFERENCES address(id),
    payment_method_id INT REFERENCES payment_method(id),
    subtotal DECIMAL(10, 2) NOT NULL,
    tax_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    shipping_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    discount_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(10, 2) NOT NULL,
    notes TEXT,
    tracking_number VARCHAR(100),
    payment_transaction_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create order_item table
CREATE TABLE order_item (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES product(id) ON DELETE SET NULL,
    product_name VARCHAR(255) NOT NULL,  -- Store name at time of order
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create wishlist table
CREATE TABLE wishlist (
    id SERIAL PRIMARY KEY,
    account_id INT REFERENCES account(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create wishlist_item table
CREATE TABLE wishlist_item (
    wishlist_id INT REFERENCES wishlist(id) ON DELETE CASCADE,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (wishlist_id, product_id)
);

-- Create reviews table
CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    account_id INT REFERENCES account(id) ON DELETE SET NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR(255),
    comment TEXT,
    is_verified_purchase BOOLEAN DEFAULT false,
    is_approved BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create product view history
CREATE TABLE product_view (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    account_id INT REFERENCES account(id) ON DELETE CASCADE,
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create discount/coupon table
CREATE TABLE discount (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE,
    description TEXT,
    discount_type VARCHAR(20) NOT NULL, -- 'percentage', 'fixed_amount'
    discount_value DECIMAL(10, 2) NOT NULL,
    min_purchase_amount DECIMAL(10, 2),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    max_uses INT,
    current_uses INT DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create discount_product junction table for product-specific discounts
CREATE TABLE discount_product (
    discount_id INT REFERENCES discount(id) ON DELETE CASCADE,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    PRIMARY KEY (discount_id, product_id)
);

-- Create discount_category junction table for category-wide discounts
CREATE TABLE discount_category (
    discount_id INT REFERENCES discount(id) ON DELETE CASCADE,
    category_id INT REFERENCES category(id) ON DELETE CASCADE,
    PRIMARY KEY (discount_id, category_id)
);

-- Insert seed data into user_role
INSERT INTO user_role (role_name, description) VALUES
    ('admin', 'Full access to all features and settings'),
    ('customer', 'Standard customer account with basic shopping privileges');

-- Insert seed data into account
INSERT INTO account (username, pass, email, first_name, last_name, role_id) VALUES
    ('admin', '$2a$12$tAUXdl9jWgLhOuJGQj2wL.YbXFpEO3MpZY5VXm/HSKjzHYWkFDDPa', 'admin@gamestore.com', 'Admin', 'User', 1), -- Password: admin123
    ('johndoe', '$2a$12$S3sfLuHQGmDQVvI3QXtPcemEKTtEGCBxJ8Y95XoDxmXOGJ8J7xsXe', 'john.doe@example.com', 'John', 'Doe', 2), -- Password: password123
    ('janesmith', '$2a$12$NnaIwgr20bQUAzhcLYLgkOo7TPDEdSfZDlMlZ3UvLGAfRW99d4ZDy', 'jane.smith@example.com', 'Jane', 'Smith', 2), -- Password: password123
    ('bobmartin', '$2a$12$cA.qVZ1qS0WVrGrNGHl38ef3h9y9F.lmogTW/UEjbHdKqbPiROQ8y', 'bob.martin@example.com', 'Bob', 'Martin', 2), -- Password: password123
    ('alicejohnson', '$2a$12$zJLVQPkW.Rp5J5DRvKUxnO3EGQa9KQygOHJsC.LNlOJs6HZTOwjP.', 'alice.johnson@example.com', 'Alice', 'Johnson', 2); -- Password: password123

-- Insert seed data into publisher
INSERT INTO publisher (name, website, founded_year, description) VALUES
    ('CD Projekt Red', 'https://www.cdprojektred.com', 1994, 'Polish video game developer, publisher and distributor based in Warsaw.'),
    ('Valve Corporation', 'https://www.valvesoftware.com', 1996, 'American video game developer, publisher and digital distribution company.'),
    ('Electronic Arts', 'https://www.ea.com', 1982, 'American video game company headquartered in Redwood City, California.'),
    ('Ubisoft', 'https://www.ubisoft.com', 1986, 'French video game company headquartered in Montreuil.'),
    ('Bethesda Softworks', 'https://bethesda.net', 1986, 'American video game publisher based in Rockville, Maryland.'),
    ('Capcom', 'https://www.capcom.com', 1979, 'Japanese video game developer and publisher.'),
    ('Square Enix', 'https://www.square-enix.com', 1975, 'Japanese video game company known for Final Fantasy and Dragon Quest.'),
    ('Rockstar Games', 'https://www.rockstargames.com', 1998, 'American video game publisher based in New York City.');

-- Insert seed data into developer
INSERT INTO developer (name, website, founded_year, description) VALUES
    ('CD Projekt Red', 'https://www.cdprojektred.com', 1994, 'Polish video game developer best known for The Witcher series.'),
    ('Valve Corporation', 'https://www.valvesoftware.com', 1996, 'American video game developer known for Half-Life and Portal.'),
    ('BioWare', 'https://www.bioware.com', 1995, 'Canadian video game developer known for Mass Effect and Dragon Age.'),
    ('Naughty Dog', 'https://www.naughtydog.com', 1984, 'American video game developer known for Uncharted and The Last of Us.'),
    ('Bethesda Game Studios', 'https://bethesdagamestudios.com', 2001, 'American video game developer known for The Elder Scrolls and Fallout.'),
    ('Capcom', 'https://www.capcom.com', 1979, 'Japanese video game developer known for Resident Evil and Monster Hunter.'),
    ('Square Enix', 'https://www.square-enix.com', 1975, 'Japanese video game developer known for Final Fantasy and Kingdom Hearts.'),
    ('Rockstar North', 'https://www.rockstargames.com', 1988, 'British video game developer known for Grand Theft Auto.'),
    ('FromSoftware', 'https://www.fromsoftware.jp', 1986, 'Japanese video game developer known for Dark Souls and Elden Ring.'),
    ('ZA/UM', 'https://zaumstudio.com/', 2016, 'Estonian video game developer known for Disco Elysium.');

-- Insert seed data into category
INSERT INTO category (name, description, display_order) VALUES
    ('Adventure', 'Games that focus on exploration, puzzle-solving, and narrative', 1),
    ('RPG', 'Role-playing games with character progression and story-driven gameplay', 2),
    ('Horror', 'Frightening games designed to scare and unsettle players', 3),
    ('Strategy', 'Games that prioritize thoughtful planning and tactical decision-making', 4),
    ('FPS', 'First-person shooter games focusing on weapon-based combat', 5),
    ('Racing', 'Games focusing on driving and competing with vehicles', 6),
    ('Simulation', 'Games designed to simulate real-world activities', 7),
    ('Sports', 'Games based on real-world sports competitions', 8),
    ('Platformer', 'Games involving jumping between platforms and obstacles', 9),
    ('Puzzle', 'Games that emphasize puzzle solving', 10),
    ('Open World', 'Games featuring vast, freely explorable environments', 11),
    ('Stealth', 'Games emphasizing avoiding detection and strategic movement', 12);

-- Insert seed data into platform
INSERT INTO platform (name, abbreviation, manufacturer, release_year) VALUES
    ('PlayStation 5', 'PS5', 'Sony', 2020),
    ('PlayStation 4', 'PS4', 'Sony', 2013),
    ('Xbox Series X', 'XSX', 'Microsoft', 2020),
    ('Xbox One', 'XB1', 'Microsoft', 2013),
    ('Nintendo Switch', 'NSW', 'Nintendo', 2017),
    ('PC', 'PC', 'Various', NULL),
    ('iOS', 'iOS', 'Apple', 2007),
    ('Android', 'AND', 'Google', 2008);

-- Insert seed data into product with more complete information
INSERT INTO product (name, slug, sku, image_url, price, sale_price, description, publisher_id, developer_id, category_id, release_date, age_rating, rating, stock_quantity, is_digital, is_featured) VALUES
    ('The Witcher 3: Wild Hunt', 'the-witcher-3-wild-hunt', 'WITCHER3', 'https://en.cdprojektred.com/wp-content/uploads-cdpr-en/2021/07/th-98654-38843.jpg', 39.99, 19.99, 'The Witcher 3: Wild Hunt is a story-driven open world RPG set in a visually stunning fantasy universe full of meaningful choices and impactful consequences. In The Witcher, you play as professional monster hunter Geralt of Rivia tasked with finding a child of prophecy in a vast open world rich with merchant cities, pirate islands, dangerous mountain passes, and forgotten caverns to explore.', 1, 1, 2, '2015-05-18', 'M', 4.9, 500, true, true),
    
    ('Cyberpunk 2077', 'cyberpunk-2077', 'CP2077', 'https://www.cyberpunk.net/build/images/home3/screen-image-poster-3-3840x2160@2x-cbbfd3d2.jpg', 59.99, 29.99, 'Cyberpunk 2077 is an open-world, action-adventure RPG set in Night City, a megalopolis obsessed with power, glamour and body modification. You play as V, a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality.', 1, 1, 2, '2020-12-10', 'M', 4.2, 750, true, false),
    
    ('Red Dead Redemption 2', 'red-dead-redemption-2', 'RDR2', 'https://media.rockstargames.com/rockstargames/img/global/news/upload/actual_1540383742.jpg', 59.99, 39.99, 'America, 1899. The end of the Wild West era has begun. After a robbery goes badly wrong in the western town of Blackwater, Arthur Morgan and the Van der Linde gang are forced to flee. With federal agents and the best bounty hunters in the nation massing on their heels, the gang must rob, steal and fight their way across the rugged heartland of America in order to survive.', 8, 8, 1, '2018-10-26', 'M', 4.8, 350, true, true),
    
    ('Disco Elysium - The Final Cut', 'disco-elysium-the-final-cut', 'DISCO', 'https://cutewallpaper.org/22/disco-elysium-wallpapers/2517220073.jpg', 39.99, 19.99, 'Disco Elysium - The Final Cut is the definitive edition of the groundbreaking role playing game. You're a detective with a unique skill system at your disposal and a whole city block to carve your path across. Interrogate unforgettable characters, crack murders, or take bribes. Become a hero or an absolute disaster of a human being.', 2, 10, 2, '2019-10-15', 'M', 4.8, 200, true, false),
    
    ('Resident Evil Village', 'resident-evil-village', 'REV', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1196590/capsule_616x353.jpg?t=1644282145', 49.99, 29.99, 'Experience survival horror like never before in the eighth major installment in the storied Resident Evil franchise - Resident Evil Village. Set a few years after the horrifying events in the critically acclaimed Resident Evil 7 biohazard, the all-new storyline begins with Ethan Winters and his wife Mia living peacefully in a new location, free from their past nightmares.', 6, 6, 3, '2021-05-07', 'M', 4.6, 300, true, false),
    
    ('Elden Ring', 'elden-ring', 'ELDEN', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1245620/header.jpg?t=1654259241', 59.99, NULL, 'THE NEW FANTASY ACTION RPG. Rise, Tarnished, and be guided by grace to brandish the power of the Elden Ring and become an Elden Lord in the Lands Between.', 5, 9, 2, '2022-02-25', 'M', 4.9, 1000, true, true),
    
    ('Horizon Forbidden West', 'horizon-forbidden-west', 'HFW', 'https://image.api.playstation.com/vulcan/ap/rnd/202107/3100/HO8vkO9K3ztRuIEjwubWrYuF.png', 69.99, 49.99, 'Join Aloy as she braves the Forbidden West – a majestic but dangerous frontier that conceals mysterious new threats.', 4, 4, 1, '2022-02-18', 'T', 4.7, 250, false, true),
    
    ('FIFA 23', 'fifa-23', 'FIFA23', 'https://media.contentapi.ea.com/content/dam/ea/fifa/fifa-23/world-cup/common/f23-worldcup-16x9.png.adapt.crop16x9.1023w.png', 59.99, 39.99, 'EA SPORTS™ FIFA 23 brings The World's Game to the pitch with HyperMotion2 Technology, FIFA World Cup™ men's and women's tournaments, women's club teams, cross-play features, and more.', 3, 3, 8, '2022-09-30', 'E', 4.1, 500, true, false),
    
    ('Hades', 'hades', 'HADES', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1145360/header.jpg?t=1624463563', 24.99, 19.99, 'Hades is a god-like rogue-like dungeon crawler that combines the best aspects of Supergiant's critically acclaimed titles, including the fast-paced action of Bastion, the rich atmosphere and depth of Transistor, and the character-driven storytelling of Pyre.', 2, 2, 2, '2020-09-17', 'T', 4.9, 150, true, false),
    
    ('The Last of Us Part II', 'the-last-of-us-part-2', 'TLOU2', 'https://cdn.cloudflare.steamstatic.com/steam/apps/1888930/header.jpg?t=1686286293', 59.99, 39.99, 'Five years after their dangerous journey across the post-pandemic United States, Ellie and Joel have settled down in Jackson, Wyoming. Living amongst a thriving community of survivors has allowed them peace and stability, despite the constant threat of the infected and other, more desperate survivors.', 4, 4, 3, '2020-06-19', 'M', 4.8, 200, false, true);

-- Insert data into product_platform
INSERT INTO product_platform (product_id, platform_id) VALUES
    (1, 2), (1, 3), (1, 4), (1, 6), -- Witcher 3: PS4, Xbox Series X, Xbox One, PC
    (2, 1), (2, 2), (2, 3), (2, 4), (2, 6), -- Cyberpunk: PS5, PS4, Xbox Series X, Xbox One, PC
    (3, 1), (3, 2), (3, 3), (3, 4), (3, 6), -- RDR2: PS5, PS4, Xbox Series X, Xbox One, PC
    (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), -- Disco Elysium: PS5, PS4, Xbox Series X, Xbox One, Switch, PC
    (5, 1), (5, 2), (5, 3), (5, 4), (5, 6), -- RE Village: PS5, PS4, Xbox Series X, Xbox One, PC
    (6, 1), (6, 2), (6, 3), (6, 4), (6, 6), -- Elden Ring: PS5, PS4, Xbox Series X, Xbox One, PC
    (7, 1), (7, 2), -- Horizon: PS5, PS4
    (8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6), -- FIFA: PS5, PS4, Xbox Series X, Xbox One, Switch, PC
    (9, 1), (9, 2), (9, 3), (9, 4), (9, 5), (9, 6), (9, 7), (9, 8), -- Hades: All platforms
    (10, 1), (10, 2); -- TLOU2: PS5, PS4

-- Insert data into product_image (multiple images per product)
INSERT INTO product_image (product_id, image_url, alt_text, display_order) VALUES
    (1, 'https://en.cdprojektred.com/wp-content/uploads-cdpr-en/2021/07/th-98654-38843.jpg', 'Witcher 3 Main Image', 1),
    (1, 'https://www.gamespace.com/wp-content/uploads/2019/06/The-Witcher-3-Wild-Hunt.jpg', 'Witcher 3 Gameplay', 2),
    (1, 'https://cdn.mos.cms.futurecdn.net/SbovjoX2wBzMqYtHkPsAXm.jpg', 'Witcher 3 Combat', 3),
    (2, 'https://www.cyberpunk.net/build/images/home3/screen-image-poster-3-3840x2160@2x-cbbfd3d2.jpg', 'Cyberpunk 2077 Main Image', 1),
    (2, 'https://cdn.vox-cdn.com/thumbor/Lg6x7Chp7LR6MFoTAj3TnkjKtIw=/1400x788/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/22137584/Cyberpunk2077_Always_bring_a_gun_to_a_knife_fight_RGB_en.jpg', 'Cyberpunk 2077 Combat', 2);

-- Insert data into tag
INSERT INTO tag (name) VALUES
    ('Open World'),
    ('RPG'),
    ('Action'),
    ('Adventure'),
    ('Horror'),
    ('Shooter'),
    ('Fantasy'),
    ('Sci-Fi'),
    ('Sports'),
    ('Racing'),
    ('Multiplayer'),
    ('Single Player'),
    ('Story Rich'),
    ('Atmospheric'),
    ('Difficult');

-- Link products with tags
INSERT INTO product_tag (product_id, tag_id) VALUES
    (1, 1), (1, 2), (1, 3), (1, 4), (1, 7), (1, 12), (1, 13), -- Witcher 3 tags
    (2, 1), (2, 2), (2, 3), (2, 4), (2, 8), (2, 12), (2, 13), -- Cyberpunk tags
    (3, 1), (3, 3), (3, 4), (3, 12), (3, 13), (3, 14), -- RDR2 tags
    (4, 2), (4, 12), (4, 13), (4, 14), -- Disco Elysium tags
    (5, 3), (5, 4), (5, 5), (5, 12), (5, 14), -- RE Village tags
    (6, 1), (6, 2), (6, 3), (6, 7), (6, 12), (6, 15); -- Elden Ring tags

-- Insert data into order_status
INSERT INTO order_status (name, description, display_order) VALUES
    ('Pending', 'Order has been placed but not yet processed', 1),
    ('Processing', 'Order is being prepared for shipping', 2),
    ('Shipped', 'Order has been shipped', 3),
    ('Delivered', 'Order has been delivered', 4),
    ('Cancelled', 'Order has been cancelled', 5),
    ('Refunded', 'Order has been refunded', 6);

-- Insert data into payment_method
INSERT INTO payment_method (name) VALUES
    ('Credit Card'),
    ('PayPal'),
    ('Bank Transfer'),
    ('Store Credit'),
    ('Cryptocurrency');

-- Insert addresses for users
INSERT INTO address (account_id, address_type, address_line1, city, postal_code, country) VALUES
    (2, 'shipping', '123 Main St', 'New York', '10001', 'United States'),
    (2, 'billing', '123 Main St', 'New York', '10001', 'United States'),
    (3, 'shipping', '456 Oak Ave', 'Los Angeles', '90001', 'United States'),
    (3, 'billing', '456 Oak Ave', 'Los Angeles', '90001', 'United States');

-- Insert orders data
INSERT INTO orders (order_number, account_id, status_id, billing_address_id, shipping_address_id, payment_method_id, subtotal, tax_amount, total_amount, created_at) VALUES
    ('ORD-20230501-00001', 2, 4, 2, 1, 1, 59.99, 5.40, 65.39, '2023-05-01 14:23:45'),
    ('ORD-20230515-00002', 3, 3, 4, 3, 2, 79.98, 7.20, 87.18, '2023-05-15 09:12:30'),
    ('ORD-20230518-00003', 2, 2, 2, 1, 1, 129.98, 11.70, 141.68, '2023-05-18 18:45:22');

-- Insert order items
INSERT INTO order_item (order_id, product_id, product_name, quantity, unit_price, subtotal) VALUES
    (1, 1, 'The Witcher 3: Wild Hunt', 1, 59.99, 59.99),
    (2, 4, 'Disco Elysium - The Final Cut', 2, 39.99, 79.98),
    (3, 2, 'Cyberpunk 2077', 1, 59.99, 59.99),
    (3, 5, 'Resident Evil Village', 1, 69.99, 69.99);

-- Create wishlists
INSERT INTO wishlist (account_id) VALUES (2), (3), (4);

-- Add items to wishlists
INSERT INTO wishlist_item (wishlist_id, product_id) VALUES
    (1, 6), (1, 7), (1, 8),  -- User 2's wishlist
    (2, 3), (2, 9),          -- User 3's wishlist
    (3, 1), (3, 2), (3, 5);  -- User 4's wishlist

-- Add some reviews
INSERT INTO review (product_id, account_id, rating, title, comment, is_verified_purchase, is_approved) VALUES
    (1, 2, 5, 'Best RPG Ever!', 'The Witcher 3 is an absolute masterpiece. The world is immersive, the characters are deep and well-written, and the quests are engaging. I highly recommend it to any RPG fan.', true, true),
    (1, 3, 4, 'Great Game, Minor Issues', 'Witcher 3 is amazing overall, but there are some minor performance issues on older consoles.', true, true),
    (2, 4, 4, 'Much Improved Since Launch', 'Cyberpunk had a rough start but with all the patches, it''s now a great game with an amazing story.', true, true),
    (3, 2, 5, 'Breathtaking Western Experience', 'Red Dead Redemption 2 has the most detailed and alive open world I have ever seen in a game. The story is emotional and powerful.', true, true);

-- Create discounts/coupons
INSERT INTO discount (code, description, discount_type, discount_value, min_purchase_amount, start_date, end_date, max_uses, is_active) VALUES
    ('SUMMER2023', '20% off all games for summer sale', 'percentage', 20.00, 25.00, '2023-06-01', '2023-08-31', 1000, true),
    ('WELCOME10', '$10 off first purchase', 'fixed_amount', 10.00, 30.00, '2023-01-01', '2023-12-31', 5000, true),
    ('RPG25', '25% off select RPG games', 'percentage', 25.00, NULL, '2023-05-01', '2023-07-31', 500, true);

-- Link discounts to categories
INSERT INTO discount_category (discount_id, category_id) VALUES
    (3, 2); -- RPG25 discount applies to RPG category

-- Set up indexes for better query performance
CREATE INDEX idx_order_account ON orders(account_id);
CREATE INDEX idx_order_date ON orders(created_at);
CREATE INDEX idx_review_product ON review(product_id);
CREATE INDEX idx_wishlist_item_product ON wishlist_item(product_id);
CREATE INDEX idx_product_view_account ON product_view(account_id);
CREATE INDEX idx_product_view_product ON product_view(product_id);

-- Create a function to update timestamp on record updates
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers to automatically update timestamps
CREATE TRIGGER update_account_timestamp
BEFORE UPDATE ON account
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_product_timestamp
BEFORE UPDATE ON product
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_orders_timestamp
BEFORE UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

-- Create view for product sales analytics
CREATE VIEW product_sales AS
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    c.name AS category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.subtotal) AS total_revenue
FROM product p
JOIN order_item oi ON p.id = oi.product_id
JOIN orders o ON oi.order_id = o.id
JOIN category c ON p.category_id = c.id
WHERE o.status_id NOT IN (5, 6) -- Exclude cancelled and refunded orders
GROUP BY p.id, p.name, c.name
ORDER BY total_revenue DESC;

-- Create view for product rating summary
CREATE VIEW product_rating_summary AS
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    COUNT(r.id) AS review_count,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM product p
LEFT JOIN review r ON p.id = r.product_id
WHERE r.is_approved = true
GROUP BY p.id, p.name
ORDER BY avg_rating DESC; 