CREATE DATABASE GameStore
GO
USE GameStore
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Account(
id int identity(1, 1) not null,
[user] varchar(255) null,
pass varchar(255) null,
[admin] int null
CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Category(
id int identity(1,1) not null,
name varchar(255) not null,
CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Product(
id int identity(1,1) not null,
name varchar(255) null,
[image] varchar(max) null,
price float null,
[description] varchar(max) null,
cid int null,
releasedate varchar(255) null,
rating float null
CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Order](
id int identity(1,1) not null,
[uid] int null,
total float null
CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE OrderDetail(
oid int not null,
pid int not null,
quantity int null,
price float null,
CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	oid ASC,
	pid ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON
INSERT [dbo].[Account] (id, [user], pass, [admin]) VALUES (1, 'huyvqhe163784', 'deptrai2806', 1)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Category] ON
INSERT INTO [dbo].[Category] (id, name) VALUES(1, 'Adventure'), (2, 'RPG'), (3, 'Horror'), (4, 'Strategy'), (5, 'FPS'), (6, 'Racing')
SET IDENTITY_INSERT [dbo].[Category] OFF

INSERT INTO dbo.[Product] VALUES 
('The Witcher: Enhanced Edition', 'https://photo.techrum.vn/images/2021/12/18/the-witcher-enhanced-edition-free-TECHRUM-cover41bafc7d6a48d5de.jpg', 6.0, 'The Witcher is a role-playing game set in a dark fantasy world where moral ambiguity reigns. Shattering the line between good and evil, the game emphasizes story and character development, while incorporating a tactically-deep, real-time combat system. Become The Witcher, Geralt of Rivia, and get caught in a web of intrigue woven by forces vying for control of the world. Make difficult decisions and live with the consequences in a game that will immerse you in an extraordinary tale like no other.', 2, '16/09/2008', 4.7),
('The Witcher 2: Assassins of Kings Enhanced Edition', 'https://www.wallpaperflare.com/static/883/1008/871/the-witcher-2-assassins-of-kings-the-witcher-geralt-of-rivia-witcher-wallpaper.jpg', 12.0, 'The second installment in the RPG saga about professional monster slayer Geralt of Rivia, The Witcher 2: Assassins of Kings spins a mature, thought-provoking tale to produce one of the most elaborate and unique role-playing games ever released on PC. A time of untold chaos has come. Mighty forces clash behind the scenes in a struggle for power and influence. The Northern Kingdoms mobilize for war. But armies on the march are not enough to stop a bloody conspiracy...', 2, '17/05/2011', 4.6),
('The Witcher® 3: Wild Hunt', 'https://en.cdprojektred.com/wp-content/uploads-cdpr-en/2021/07/th-98654-38843.jpg', 20.99, 'The Witcher 3: Wild Hunt is a story-driven open world RPG set in a visually stunning fantasy universe full of meaningful choices and impactful consequences. In The Witcher, you play as professional monster hunter Geralt of Rivia tasked with finding a child of prophecy in a vast open world rich with merchant cities, pirate islands, dangerous mountain passes, and forgotten caverns to explore.', 2, '18/5/2015', 5.0),
('Thronebreaker: The Witcher Tales', 'https://wallpapercave.com/wp/wp7219731.jpg', 22.99, 'Thronebreaker is a single player role-playing game set in the world of The Witcher that combines narrative-driven exploration with unique puzzles and card battle mechanics. Crafted by the developers responsible for some of the most iconic moments in The Witcher 3: Wild Hunt, the game spins a truly regal tale of Meve, a war-veteran and queen of two Northern Realms — Lyria and Rivia. Facing an imminent Nilfgaardian invasion, Meve is forced to once again enter the warpath and set out on a dark journey of destruction and revenge.', 4, '10/11/2018', 4.5),
('GWENT: The Witcher Card Game', 'https://www.playgwent.com/img/thumbnail/social-en.jpg', 0.0, 'Join in The Witcher universe’s favorite card game — available for free! Blending the CCG and TCG genres, GWENT sees you clash in fast-paced online PvP duels that combine bluffing, on-the-fly decision making and careful deck construction. Collect and command Geralt, Yennefer and other iconic Witcher-world heroes. Grow your collectible arsenal with spells and special abilities that dramatically turn the tide of battle. Use deception and clever tricks in your strategy to win the fight in classic, seasonal and Arena modes. Play GWENT: The Witcher Card Game for free now!', 4, '19/5/2020', 4.5),
('Disco Elysium - The Final Cut', 'https://cutewallpaper.org/22/disco-elysium-wallpapers/2517220073.jpg', 15.00, 'Disco Elysium - The Final Cut is the definitive edition of the groundbreaking role playing game. You’re a detective with a unique skill system at your disposal and a whole city block to carve your path across. Interrogate unforgettable characters, crack murders, or take bribes. Become a hero or an absolute disaster of a human being.', 2, '15/11/2019', 4.8),
('Deus Ex: Game of the Year Edition', 'https://cdn-ext.fanatical.com/production/product/1280x720/c7b44d41-0d82-43ee-b133-62f9675ec6a0.jpeg', 7.0, 'The year is 2052 and the world is a dangerous and chaotic place. Terrorists operate openly - killing thousands; drugs, disease and pollution kill even more. The worlds economies are close to collapse and the gap between the insanely wealthy and the desperately poor grows ever wider. Worst of all, an ages old conspiracy bent on world domination has decided that the time is right to emerge from the shadows and take control.', 2, '22/6/2000', 4.5),
('Deus Ex: Human Revolution - Directors Cut', 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/f9038cdf-8f10-4fd4-8723-059ad1abd8cf/d68v0yi-d9806764-891f-412e-8a16-9e73d17ae1d8.jpg/v1/fill/w_1192,h_670,q_70,strp/deus_ex_human_revolution_director_s_cut__wallpaper_by_christian2506_d68v0yi-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcL2Y5MDM4Y2RmLThmMTAtNGZkNC04NzIzLTA1OWFkMWFiZDhjZlwvZDY4djB5aS1kOTgwNjc2NC04OTFmLTQxMmUtOGExNi05ZTczZDE3YWUxZDguanBnIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.TTmvrt0hpTUC1fRXrkikmGAoryZDwIt7fjuONShtitc', 20.00, N'You play Adam Jensen, an ex-SWAT specialist whos been handpicked to oversee the defensive needs of one of Americas most experimental biotechnology firms. Your job is to safeguard company secrets, but when a black ops team breaks in and kills the very scientists you were hired to protect, everything you thought you knew about your job changes.', 2, '26/11/2013', '4.6'),
('Deus Ex: Mankind Divided', 'https://i0.wp.com/thegamefanatics.com/wp-content/uploads/2015/09/Deus-Ex-Mankind-Divided.jpg?fit=1920%2C1080&ssl=1', 25.00, 'The year is 2029, and mechanically augmented humans have now been deemed outcasts, living a life of complete and total segregation from the rest of society. Now an experienced covert operative, Adam Jensen is forced to operate in a world that has grown to despise his kind. Armed with a new arsenal of state-of-the-art weapons and augmentations, he must choose the right approach, along with who to trust, in order to unravel a vast worldwide conspiracy.', 2, '23/08/2016', 4.9),
('UNCHARTED™: Legacy of Thieves Collection', 'https://static0.gamerantimages.com/wordpress/wp-content/uploads/2021/09/Uncharted-Legacy-Of-Thieves-Collection-A-Steal.jpg', 45.99, 'Are You Ready To Seek Your Fortune? Seek your fortune and leave your mark on the map in the UNCHARTED: Legacy of Thieves Collection. Uncover the thrilling cinematic storytelling and the largest blockbuster action set pieces in the UNCHARTED franchise, packed with all the wit, cunning, and over the top moments of the beloved thieves – Nathan Drake and Chloe Frazer. In an experience delivered by award winning developer Naughty Dog can, the UNCHARTED: Legacy of Thieves Collection includes the two critically-acclaimed, globe-trotting single player adventures from UNCHARTED™ 4: A Thief’s End and UNCHARTED™: The Lost Legacy. Each story is filled with laughs, drama, high octane combat, and a sense of wonder – remastered to be even more immersive.', 1, '17/5/2022', 4.7),
('Resident Evil', 'https://cdn-ext.fanatical.com/production/product/1280x720/fdb61129-3268-40ea-bce4-b776ae36e0ef.jpeg', 9.99, 'In 1998 a special forces team is sent to investigate some bizarre murders on the outskirts of Raccoon City. Upon arriving they are attacked by a pack of blood-thirsty dogs and are forced to take cover in a nearby mansion. But the scent of death hangs heavy in the air. Supplies are scarce as they struggle to stay alive.', 3, '22/3/2002', 4.5),
('Titanfall® 2', 'https://wallpaperaccess.com/full/671644.jpg', 29.99, 'Call down your Titan and get ready for an exhilarating first-person shooter experience in Titanfall® 2! The sequel introduces a new single player campaign that explores the bond between Pilot and Titan. Or blast your way through an even more innovative and intense multiplayer experience - featuring 6 new Titans, deadly new Pilot abilities, expanded customization, new maps, modes, and much more.', 5, '28/10/2016', 4.7),
('DOOM Eternal', 'https://wallpaperaccess.com/full/2631923.png', 36.99, 'Hell’s armies have invaded Earth. Become the Slayer in an epic single-player campaign to conquer demons across dimensions and stop the final destruction of humanity.
The Only Thing they Fear... Is You.
Experience the ultimate combination of speed and power in DOOM Eternal - the next leap in push-forward, first-person combat.', 5, '20/3/2020', 4.7),
('DiRT Rally 2.0', 'https://d2ofqe7l47306o.cloudfront.net/games/1920x1080/dirt-rally-2-volkswagen-polor5-psolberg-2.jpg', 15.99, 'DiRT Rally 2.0 dares you to carve your way through a selection of iconic rally locations from across the globe, in the most powerful off-road vehicles ever made, knowing that the smallest mistake could end your stage.', 6, '26/2/2019', 4.5)


GO
ALTER TABLE [dbo].[Product] WITH CHECK ADD CONSTRAINT [FK_Category] FOREIGN KEY (cid) REFERENCES [dbo].[Category] (id)
GO
ALTER TABLE [dbo].[Order] WITH CHECK ADD CONSTRAINT [FK_Order_Account] FOREIGN KEY ([uid]) REFERENCES [dbo].[Account] (id)
GO
ALTER TABLE [dbo].[Order]  CHECK CONSTRAINT [FK_Order_Account]
GO
ALTER TABLE [dbo].[OrderDetail] WITH CHECK ADD CONSTRAINT [FK_Order_OrderDetail] FOREIGN KEY (oid) REFERENCES [dbo].[Order] (id)
GO
ALTER TABLE [dbo].[OrderDetail]  CHECK CONSTRAINT [FK_Order_OrderDetail]
GO
ALTER TABLE [dbo].[OrderDetail] WITH CHECK ADD CONSTRAINT [FK_Product_OrderDetail] FOREIGN KEY (pid) REFERENCES [dbo].[Product] (id)
GO
ALTER TABLE [dbo].[OrderDetail]  CHECK CONSTRAINT [FK_Product_OrderDetail]
GO
