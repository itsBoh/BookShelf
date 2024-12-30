DROP DATABASE bookshelf;
DROP USER 'book_reader'@'localhost';
DROP USER 'Admin'@'localhost';

CREATE DATABASE bookshelf;

USE bookshelf;

CREATE TABLE Accounts (
    accountID VARCHAR(255) PRIMARY KEY,
    accountUserName VARCHAR(255) UNIQUE NOT NULL,
    accountName VARCHAR(255) NOT NULL,
    accountType VARCHAR(5) NOT NULL,
    accountPassword VARCHAR(255) NOT NULL,
    accountPhoneNumber VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Books (
    bookID VARCHAR(255) PRIMARY KEY,
    bookTitle VARCHAR(255) NOT NULL,
    bookAuthor VARCHAR(255) NOT NULL,
    bookDescription LONGTEXT,
    bookPublisher VARCHAR(255) NOT NULL,
    bookPublished INT,
    bookCoverImage LONGTEXT,
    bookAvailableCopies INT
);

CREATE TABLE Loans (
    loanID VARCHAR(255) PRIMARY KEY,
    accountID VARCHAR(255) NOT NULL,
    bookID VARCHAR(255) NOT NULL,
    loanDate DATE NOT NULL,
    loanDueDate DATE NOT NULL,
    loanReturnDate DATE,
    FOREIGN KEY (accountID) REFERENCES Accounts(accountID),
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
);

DELIMITER //

CREATE TRIGGER before_insert_accounts
BEFORE INSERT ON Accounts
FOR EACH ROW
BEGIN
    SET NEW.accountID = LPAD(CONV(FLOOR(RAND() * 16777216), 10, 36), 8, '0'); 
END //

CREATE TRIGGER before_insert_books
BEFORE INSERT ON Books
FOR EACH ROW
BEGIN
    SET NEW.bookID = LPAD(CONV(FLOOR(RAND() * 16777216), 10, 36), 8, '0'); 
END //

CREATE TRIGGER before_insert_loans
BEFORE INSERT ON Loans
FOR EACH ROW
BEGIN
    SET NEW.loanID = LPAD(CONV(FLOOR(RAND() * 16777216), 10, 36), 8, '0'); 
END //

DELIMITER ;


#Input
INSERT INTO `Accounts` (`accountUserName`, `accountName`, `accountType`, `accountPassword`, `accountPhoneNumber`) VALUES
	('john_doe', 'John Doe', 'Admin', 'password123', '081234567890'),
	('jane_smith', 'Jane Smith', 'User', 'password456', '085678901234'),
	('david_lee', 'David Lee', 'User', 'password789', '089012345678'),
	('sarah_jones', 'Sarah Jones', 'User', 'password101', '087890123456'),
	('michael_brown', 'Michael Brown', 'Admin', 'password111', '082345678901'),
	('emily_davis', 'Emily Davis', 'User', 'password222', '088901234567'),
	('daniel_green', 'Daniel Green', 'User', 'password333', '083456789012'),
	('olivia_miller', 'Olivia Miller', 'User', 'password444', '086789012345'),
	('james_wilson', 'James Wilson', 'User', 'password555', '084567890123'),
	('chloe_taylor', 'Chloe Taylor', 'User', 'password666', '081112223333');

INSERT INTO books (bookID, bookTitle, bookAuthor, bookDescription, bookPublisher, bookPublished, bookCoverImage, bookAvailableCopies) VALUES
	('1', 'Control Your Mind and Master Your Feelings: Break Overthinking & Master Your Emotions', 'Eric Robertson', 'We oftentimes look towards the outside world to find the roots of our problems. However, most of the times, we should be looking inwards. Our mind and our emotions determine our state of being in the present moment. If those aspects are left unchecked, we can get easily overwhelmed and are left feeling unfulfilled every single day.
This book contains two manuscripts designed to help you discover the best and most efficient way to control your thoughts and master your feelings.
In the first part of the bundle called Breaking Overthinking, you will discover:
How overthinking can be detrimental to your social life.
The hidden dangers of overthinking and what can happen to you if it’s left untreated.
How to declutter your mind from all the noise of the modern world.
How overthinking affects your body, your energy levels, and your everyday mood.
How your surroundings affect your state of mind, and what you NEED to do in order to break out of that state.
Bad habits we perform every day and don’t even realize are destroying our sanity (and how to overcome them properly).
How to cut out toxic people from your life, which cloud your judgment and make you feel miserable.', 'Eric Robertson', '2019', 'https://itsbooo.github.io/BookShelfImages/1.jpg', '2'),
	('2', 'A Court of Mist and Fury', 'Sarah J. Maas', 'Feyre has undergone more trials than one human woman can carry in her heart. Though she\'s now been granted the powers and lifespan of the High Fae, she is haunted by her time Under the Mountain and the terrible deeds she performed to save the lives of Tamlin and his people.
As her marriage to Tamlin approaches, Feyre\'s hollowness and nightmares consume her. She finds herself split into two different people: one who upholds her bargain with Rhysand, High Lord of the feared Night Court, and one who lives out her life in the Spring Court with Tamlin. While Feyre navigates a dark web of politics, passion, and dazzling power, a greater evil looms. She might just be the key to stopping it, but only if she can harness her harrowing gifts, heal her fractured soul, and decide how she wishes to shape her future-and the future of a world in turmoil.
Bestselling author Sarah J. Maas\'s masterful storytelling brings this second book in her dazzling, sexy, action-packed series to new heights.', 'Bloomsbury Publishing', '2020', 'https://itsbooo.github.io/BookShelfImages/2.jpg', '3'),
	('3', 'Harry Potter and the Goblet of Fire', 'J. K. Rowling, Jim Kay', 'There will be three tasks, spaced throughout the school year, and they will test the champions in many different ways ... their magical prowess - their daring - their powers of deduction - and, of course, their ability to cope with danger.\'
The Triwizard Tournament is to be held at Hogwarts. Only wizards who are over seventeen are allowed to enter - but that doesn\'t stop Harry dreaming that he will win the competition. Then at Hallowe\'en, when the Goblet of Fire makes its selection, Harry is amazed to find his name is one of those that the magical cup picks out. He will face death-defying tasks, dragons and Dark wizards, but with the help of his best friends, Ron and Hermione, he might just make it through - alive!
Having become classics of our time, the Harry Potter eBooks never fail to bring comfort and escapism. With their message of hope, belonging and the enduring power of truth and love, the story of the Boy Who Lived continues to delight generations of new readers.', 'YKY, Yapı Kredi Yayınları', '2001', 'https://itsbooo.github.io/BookShelfImages/3.jpg', '7'),
	('4', 'The Secret Language of Birthdays: Personology Profiles for Each Day of the Year', 'Gary Goldschneider, Joost Elffers', 'Many have suspected that your birthday affects your personality and how you relate to others. Nineteen years and over one million copies later, The Secret Language of Birthdays continues to fascinate readers by describing the characteristics associated with being born on a particular day. And being born on a particular month describe one\'s personality..', 'Viking Studio Books, Studio', '1994', 'https://itsbooo.github.io/BookShelfImages/4.jpg', '3'),
	('5', 'The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'Aging and reclusive Hollywood movie icon Evelyn Hugo is finally ready to tell the truth about her glamorous and scandalous life. But when she chooses unknown magazine reporter Monique Grant for the job, no one is more astounded than Monique herself. Why her? Why now?
Monique is not exactly on top of the world. Her husband has left her, and her professional life is going nowhere. Regardless of why Evelyn has selected her to write her biography, Monique is determined to use this opportunity to jumpstart her career.
Summoned to Evelyn\'s luxurious apartment, Monique listens in fascination as the actress tells her story. From making her way to Los Angeles in the 1950s to her decision to leave show business in the \'80s, and, of course, the seven husbands along the way, Evelyn unspools a tale of ruthless ambition, unexpected friendship, and a great forbidden love. Monique begins to feel a very real connection to the legendary star, but as Evelyn\'s story near its conclusion, it becomes clear that her life intersects with Monique\'s own in tragic and irreversible ways.
Written with Reid\'s signature talent for creating ""complex, likable characters"" (Real Simple), this is a mesmerizing journey through the splendor of old Hollywood into the harsh realities of the present day as two women struggle with what it means—and what it costs—to face the truth', 'Atria Books', '2017', 'https://itsbooo.github.io/BookShelfImages/5.jpg', '2'),
	('6', 'A Game of Thrones', 'George R. R. Martin', 'Here is the first volume in George R. R. Martin’s magnificent cycle of novels that includes A Clash of Kings and A Storm of Swords. As a whole, this series comprises a genuine masterpiece of modern fantasy, bringing together the best the genre has to offer. Magic, mystery, intrigue, romance, and adventure fill these pages and transport us to a world unlike any we have ever experienced. Already hailed as a classic, George R. R. Martin’s stunning series is destined to stand as one of the great achievements of imaginative fiction.
A GAME OF THRONES
Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister and supernatural forces are massing beyond the kingdom’s protective Wall. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the land they were born to. Sweeping from a land of brutal cold to a distant summertime kingdom of epicurean plenty, here is a tale of lords and ladies, soldiers and sorcerers, assassins and bastards, who come together in a time of grim omens.
Here an enigmatic band of warriors bear swords of no human metal; a tribe of fierce wildlings carry men off into madness; a cruel young dragon prince barters his sister to win back his throne; and a determined woman undertakes the most treacherous of journeys. Amid plots and counterplots, tragedy and betrayal, victory and terror, the fate of the Starks, their allies, and their enemies hangs perilously in the balance, as each endeavors to win that deadliest of conflicts: the game of thrones.', 'Bantam Books', '2002', 'https://itsbooo.github.io/BookShelfImages/6.jpg', '1'),
	('7', 'The Resurrectionist: A Twisty Gothic Mystery of Dark Scottish History', 'A. Rae Dunlap', 'In the tradition of The Alienist and Anatomy: A Love Story, a decadently macabre, dark and twisty gothic debut set in 19th century Scotland – when real-life serial killers Burke and Hare terrorized the streets of Edinburgh – as a young medical student is lured into the illicit underworld of body snatching.
Historical fiction, true crime, and dark academia intertwine in a harrowing tale of murder, greed, and the grisly origins of modern medicine for readers of Lydia Kang, ML Rio, Sarah Perry, and C.E. McGill.
""With wit as sharp as a scalpel, and a plot as dark and twisted as the Edinburgh alleys in which it is set, The Resurrectionist is a thrilling debut that will have readers turning pages deep into the night."" —Hester Fox, author of The Last Heir to Blackwood Library
Edinburgh, Scotland, 1828. Naïve but determined James Willoughby has abandoned his posh, sheltered life at Oxford to pursue a lifelong dream of studying surgery in Edinburgh. A shining beacon of medical discovery in the age of New Enlightenment, the city’s university offers everything James desires—except the chance to work on a human cadaver. For that, he needs to join one of the private schools in Surgeon’s Square, at a cost he cannot afford. In desperation, he strikes a deal with Aneurin “Nye” MacKinnon, a dashing young dissectionist with an artist’s eye for anatomy and a reckless passion for knowledge. Nye promises to help him gain the surgical experience he craves—but it doesn’t take long for James to realize he’s made a devil’s bargain . . .
 
Nye is a body snatcher. And James has unwittingly become his accomplice. Intoxicated by Nye and his noble mission, James rapidly descends into the underground ranks of the Resurrectionists—the body snatchers infamous for stealing fresh corpses from churchyards to be used as anatomical specimens. Before he knows it, James is caught up in a life-or-death scheme as rival gangs of snatchers compete in a morbid race for power and prestige.
 
James and Nye soon find themselves in the crosshairs of a shady pair of unscrupulous opportunists known as Burke and Hare, who are dead set on cornering the market, no matter the cost. These unsavory characters will do anything to beat the competition for bodies. Even if it’s cold-blooded murder . . .
 
Exquisitely macabre and delightfully entertaining, The Resurrectionist combines fact and fiction in a rollicking tale of the risks and rewards of scientific pursuit, the passions of its boldest pioneers, and the anatomy of human desire.', 'Kensington Books', '2024', 'https://itsbooo.github.io/BookShelfImages/7.jpg', '1'),
	('8', 'Rental House: A Novel', 'Weike Wang', 'From the award-winning author of Chemistry, a sharp-witted, insightful novel about a marriage as seen through the lens of two family vacations
Keru and Nate are college sweethearts who marry despite their family differences: Keru’s strict, Chinese, immigrant parents demand perfection (“To use a dishwasher is to admit defeat,” says her father), while Nate’s rural, white, working-class family distrusts his intellectual ambitions and his “foreign” wife.
 
Some years into their marriage, the couple invites their families on vacation. At a Cape Cod beach house, and later at a luxury Catskills bungalow, Keru, Nate, and their giant sheepdog navigate visits from in-laws and unexpected guests, all while wondering if they have what it takes to answer the big questions: How do you cope when your spouse and your family of origin clash?  How many people (and dogs) make a family? And when the pack starts to disintegrate, what can you do to shepherd everyone back together?
With her “wry, wise, and simply spectacular” style (People) and “hilarious deadpan that recalls Gish Jen and Nora Ephron” (O, The Oprah Magazine), Weike Wang offers a portrait of family that is equally witty, incisive, and tender.', 'Riverhead Books', '2024', 'https://itsbooo.github.io/BookShelfImages/8.jpg', '6'),
	('9', 'Wind and Truth: Book Five of the Stormlight Archive ', 'Brandon Sanderson', 'The long-awaited explosive climax to the first arc of the #1 New York Times bestselling Stormlight Archive—the iconic epic fantasy masterpiece that has sold more than 10 million copies, from acclaimed bestselling author Brandon Sanderson.
Dalinar Kholin challenged the evil god Odium to a contest of champions with the future of Roshar on the line. The Knights Radiant have only ten days to prepare—and the sudden ascension of the crafty and ruthless Taravangian to take Odium’s place has thrown everything into disarray.
Desperate fighting continues simultaneously worldwide—Adolin in Azir, Sigzil and Venli at the Shattered Plains, and Jasnah in Thaylenah. The former assassin, Szeth, must cleanse his homeland of Shinovar from the dark influence of the Unmade. He is accompanied by Kaladin, who faces a new battle helping Szeth fight his own demons . . . and who must do the same for the insane Herald of the Almighty, Ishar.
At the same time, Shallan, Renarin, and Rlain work to unravel the mystery behind the Unmade Ba-Ado-Mishram and her involvement in the enslavement of the singer race and in the ancient Knights Radiant killing their spren. And Dalinar and Navani seek an edge against Odium’s champion that can be found only in the Spiritual Realm, where memory and possibility combine in chaos. The fate of the entire Cosmere hangs in the balance.', 'Tor Books', '2024', 'https://itsbooo.github.io/BookShelfImages/9.jpg', '1'),
	('10', '1984: 75th Anniversary', 'George Orwell', 'Written 75 years ago, 1984 was George Orwell’s chilling prophecy about the future. And while 1984 has come and gone, his dystopian vision of a government that will do anything to control the narrative is timelier than ever...
This 75th Anniversary Edition includes:
• A New Introduction by Dolen Perkins-Valdez, author of Take My Hand, winner of the 2023 NAACP Image Award for Outstanding Literary Work—Fiction
• A New Afterword by Sandra Newman, author of Julia: A Retelling of George Orwell’s 1984
“The Party told you to reject the evidence of your eyes and ears. It was their final, most essential command.”
Winston Smith toes the Party line, rewriting history to satisfy the demands of the Ministry of Truth. With each lie he writes, Winston grows to hate the Party that seeks power for its own sake and persecutes those who dare to commit thoughtcrimes. But as he starts to think for himself, Winston can’t escape the fact that Big Brother is always watching...
A startling and haunting novel, 1984 creates an imaginary world that is completely convincing from start to finish. No one can deny the novel’s hold on the imaginations of whole generations, or the power of its admonitions—a power that seems to grow, not lessen, with the passage of time.', 'Signet Classic', '1961', 'https://itsbooo.github.io/BookShelfImages/10.jpg', '7'),
	('11', 'A Brief History of Time', 'Stephen Hawking', 'A landmark volume in science writing by one of the great minds of our time, Stephen Hawking’s book explores such profound questions as: How did the universe begin—and what made its start possible? Does time always flow forward? Is the universe unending—or are there boundaries? Are there other dimensions in space? What will happen when it all ends?
Told in language we all can understand, A Brief History of Time plunges into the exotic realms of black holes and quarks, of antimatter and “arrows of time,” of the big bang and a bigger God—where the possibilities are wondrous and unexpected. With exciting images and profound imagination, Stephen Hawking brings us closer to the ultimate secrets at the very heart of creation.', 'Random House Publishing Group', '1998', 'https://itsbooo.github.io/BookShelfImages/11.jpg', '4'),
	('12', 'A Heartbreaking Work of Staggering Genius: Pulitzer Prize Finalist', 'Dave Eggers', 'A Heartbreaking Work of Staggering Genius is the moving memoir of a college senior who, in the space of five weeks, loses both of his parents to cancer and inherits his eight-year-old brother. This exhilarating debut that manages to be simultaneously hilarious and wildly inventive as well as a deeply heartfelt story of the love that holds a family together.', 'Vintage', '2001', 'https://itsbooo.github.io/BookShelfImages/12.jpg', '5'),
	('13', 'Long Way Gone', 'Ishmael Beah', 'This is how wars are fought now: by children, hopped-up on drugs and wielding AK-47s. Children have become soldiers of choice. In the more than fifty conflicts going on worldwide, it is estimated that there are some 300,000 child soldiers. Ishmael Beah used to be one of them.
What is war like through the eyes of a child soldier? How does one become a killer? How does one stop? Child soldiers have been profiled by journalists, and novelists have struggled to imagine their lives. But until now, there has not been a first-person account from someone who came through this hell and survived.
In A Long Way Gone, Beah, now twenty-five years old, tells a riveting story: how at the age of twelve, he fled attacking rebels and wandered a land rendered unrecognizable by violence. By thirteen, he\'d been picked up by the government army, and Beah, at heart a gentle boy, found that he was capable of truly terrible acts. This is a rare and mesmerizing account, told with real literary force and heartbreaking honesty.', 'Sarah Crichton Books', '2008', 'https://itsbooo.github.io/BookShelfImages/13.jpg', '0'),
	('14', 'The Bad Beginning: Or, Orphans!', 'Lemony Snicket', 'In the tradition of great storytellers, from Dickens to Dahl, comes an exquisitely dark comedy that is both literary and irreverent, hilarious and deftly crafted. Never before has a tale of three likeable and unfortunate children been quite so enchanting, or quite so uproariously unhappy. 
Are you made fainthearted by death? Does fire unnerve you? Is a villain something that might crop up in future nightmares of yours? Are you thrilled by nefarious plots? Is cold porridge upsetting to you? Vicious threats? Hooks? Uncomfortable clothing?
It is likely that your answers will reveal A Series of Unfortunate Events to be ill-suited for your personal use. A librarian, bookseller, or acquaintance should be able to suggest books more appropriate for your fragile temperament. But to the rarest of readers we say, ""Proceed, but cautiously.""', 'HarperCollins', '2007', 'https://itsbooo.github.io/BookShelfImages/14.jpg', '3'),
	('15', 'A Study in Drowning Collector\'s Deluxe Limited Edition', 'Ava Reid ', 'Bestselling author Ava Reid’s YA debut, the haunting stand-alone dark academia fantasy, instant Indie and #1 New York Times bestselling A Study in Drowning, is now available in a gorgeous package that also includes bonus content written by the author. With intricate foil case design, antique-style endpapers, filigree cover, custom designed edges, and bonus content, it’s a true collector’s edition. Quantities will be limited, so be sure to preorder now!
Effy Sayre has always believed in fairy tales. She’s had no choice. Since childhood, she’s been haunted by visions of the Fairy King. She’s found solace only in the pages of Angharad—author Emrys Myrddin’s beloved epic about a mortal girl who falls in love with the Fairy King and then destroys him. Effy’s tattered, dog-eared copy is all that’s keeping her afloat at Llyr’s prestigious architecture college. So when Myrddin’s family announces a contest to redesign the late author’s estate, Effy feels certain this is her destiny.
But Hiraeth Manor is an impossible task: a musty, decrepit house on the brink of crumbling into a hungry sea. And when Effy arrives, someone else has already made a temporary home there. Preston Héloury, a stodgy young literature scholar, is studying Myrddin’s papers and is determined to prove her favorite author is a fraud. As the two rivals piece together clues about the reclusive author’s legacy, dark forces, both mortal and magical, conspire against them—and the truth may bring them both to ruin.
Part historical fantasy, part rivals-to-lovers romance, part Gothic mystery, and all haunting, dreamlike atmosphere, Ava Reid\'s powerful YA debut is also an unflinching indictment of institutions that sacrifice young girls on the altar of men’s “genius” and a gripping read that will stay with you long after its final page.', 'HarperCollins', '2024', 'https://itsbooo.github.io/BookShelfImages/15.jpg', '7'),
	('16', 'Fable for the End of the World ', 'Ava Reid ', 'The Last of Us meets The Ballad of Songbirds and Snakes in this stand-alone dystopian romance about survival, sacrifice, and love that risks everything.
By encouraging massive accumulations of debt from its underclass, a single corporation, Caerus, controls all aspects of society.
Inesa lives with her brother in a half-sunken town where they scrape by running a taxidermy shop. Unbeknownst to Inesa, their cruel and indolent mother has accrued an enormous debt—enough to qualify one of her children for Caerus’s livestreamed assassination spectacle: the Lamb’s Gauntlet.
Melinoë is a Caerus assassin, trained to track and kill the sacrificial Lambs. The product of neural reconditioning and physiological alteration, she is a living weapon, known for her cold brutality and deadly beauty. She has never failed to assassinate one of her marks.
When Inesa learns that her mother has offered her as a sacrifice, at first she despairs—the Gauntlet is always a bloodbath for the impoverished debtors. But she’s had years of practice surviving in the apocalyptic wastes, and with the help of her hunter brother she might stand a chance of staying alive.
For Melinoë, this is a game she can’t afford to lose. Despite her reputation for mercilessness, she is haunted by painful flashbacks. After her last Gauntlet, where she broke down on livestream, she desperately needs redemption.
As Mel pursues Inesa across the wasteland, both girls begin to question everything: Inesa wonders if there’s more to life than survival, while Mel wonders if she’s capable of more than killing.
And both wonder if, against all odds, they might be falling in love. ', 'HarperCollins', '2024', 'https://itsbooo.github.io/BookShelfImages/16.jpg', '1'),
	('17', 'The Wolf and the Woodsman: A Novel', 'Ava Reid ', 'In the vein of Naomi Novik’s New York Times bestseller Spinning Silver and Katherine Arden’s national bestseller The Bear and the Nightingale, this unforgettable debut— inspired by Hungarian history and Jewish mythology—follows a young pagan woman with hidden powers and a one-eyed captain of the Woodsmen as they form an unlikely alliance to thwart a tyrant. 
In her forest-veiled pagan village, Évike is the only woman without power, making her an outcast clearly abandoned by the gods. The villagers blame her corrupted bloodline—her father was a Yehuli man, one of the much-loathed servants of the fanatical king. When soldiers arrive from the Holy Order of Woodsmen to claim a pagan girl for the king’s blood sacrifice, Évike is betrayed by her fellow villagers and surrendered.
But when monsters attack the Woodsmen and their captive en route, slaughtering everyone but Évike and the cold, one-eyed captain, they have no choice but to rely on each other. Except he’s no ordinary Woodsman—he’s the disgraced prince, Gáspár Bárány, whose father needs pagan magic to consolidate his power. Gáspár fears that his cruelly zealous brother plans to seize the throne and instigate a violent reign that would damn the pagans and the Yehuli alike. As the son of a reviled foreign queen, Gáspár understands what it’s like to be an outcast, and he and Évike make a tenuous pact to stop his brother.
As their mission takes them from the bitter northern tundra to the smog-choked capital, their mutual loathing slowly turns to affection, bound by a shared history of alienation and oppression. However, trust can easily turn to betrayal, and as Évike reconnects with her estranged father and discovers her own hidden magic, she and Gáspár need to decide whose side they’re on, and what they’re willing to give up for a nation that never cared for them at all. ', 'Harper Voyager', '2021', 'https://itsbooo.github.io/BookShelfImages/17.jpg', '5'),
	('18', 'Arcana Academy', 'Elise Kova', 'A woman who wields magical tarot cards lands herself in a false engagement with the headmaster of a mysterious academy in this first installment of an enthralling fantasy romance series from the bestselling author of A Deal with the Elf King.
Clara Graysword has survived the underworld of Eclipse City through thievery, luck, and a whole lot of illegal magic. After a job gone awry, Clara is sentenced to a lifetime in prison for inking tarot cards—a rare power reserved for practitioners at the elite Arcana Academy.
Just when it seems her luck has run dry, the academy’s enigmatic headmaster, Prince Kaelis, offers her an escape—for a price. Kaelis believes that Clara is the perfect tool to help him steal a tarot card from the king and use it to re-create an all-powerful card long lost to time.
In order to conceal her identity and keep her close, Kaelis brings Clara to Arcana Academy, introducing her as the newest first-year student and his bride-to-be.
Thrust into a world of arcane magic and royal intrigue, where one misstep will send her back to prison or worse, Clara finds that the prince she swore to hate may not be what he seems. But can she risk giving him power over the world—and her heart? Or will she take it for herself?', 'Del Rey', '2024', 'https://itsbooo.github.io/BookShelfImages/18.jpg', '1'),
	('19', 'A Queen of Ice (A Trial of Sorcerers Book 5) ', 'Elise Kova', 'The epic conclusion of Eira’s saga of love, loss, and power.
A pirate doesn’t ask…they take.
Eira is done playing by the rules. Done holding back her magic, her heart, and her fury. She’s ready to crush her enemies, their vision, and anyone who dares to stand in her way.
With everything on the line, Eira will show the world they were right when they called her “dangerous” all those years ago. She’s going to claim victory for herself, or die trying.
A Queen of Ice is the fifth and final book in A Trial of Sorcerers, a young adult, epic fantasy series intended for readers who love stories involving: sorcerer competitions, slow-burn romance, adventures to distant lands, good triumphing over evil, and elemental magic.', 'Silver Wing Press', '2024', 'https://itsbooo.github.io/BookShelfImages/19.jpg', '6'),
	('20', 'An Heir of Frost (A Trial of Sorcerers Book 4)', 'Elise Kova', 'The fate of five kingdoms teeters on the knife’s edge, and Eira’s destiny is in the icy grasp of the Pirate Queen.
After a narrow escape from the brutal end of the Tournament of Five Kingdoms, Eira and her friends find themselves prisoners of the legendary Pirate Queen Adela. To most, death follows shortly after the pirate queen’s icy stare. But for Eira, those all too familiar eyes hold long-sought truths.
As she and her friends dive deeper into the pirates’ world, their magic is pushed to the brink. Morals are tested. Old passions reignite, and fresh desires spark. But love can be the deadliest vulnerability.
Amidst high-seas action, close-call escapes, and unraveling the twisted political machinations that happen in the shadows of their world, a haunting question looms larger and larger:
How much are they prepared to sacrifice for what they believe in?
An Heir of Frost is the fourth book in A Trial of Sorcerers, a young adult, epic fantasy series intended for readers who love stories involving: sorcerer competitions, found family, slow-burn romance, adventures to distant lands, good triumphing over evil, and elemental magic.', 'Silver Wing Press', '2024', 'https://itsbooo.github.io/BookShelfImages/20.jpg', '1');


# Function

DELIMITER $$

CREATE FUNCTION login_check(p_username VARCHAR(255), p_password VARCHAR(255)) 
RETURNS JSON 
DETERMINISTIC
BEGIN
    DECLARE v_accountType VARCHAR(5);

    SELECT accountType INTO v_accountType
    FROM accounts
    WHERE accountUserName = p_username 
      AND accountPassword = p_password;

    IF v_accountType IS NULL THEN
        RETURN NULL; -- Login failed
    END IF;

    IF v_accountType = 'User' THEN
        RETURN JSON_OBJECT('userName', 'User', 'password', 'passwordUser');
    ELSEIF v_accountType = 'Admin' THEN
        RETURN JSON_OBJECT('userName', 'Admin', 'password', 'passwordAdmin');
    ELSE
        RETURN NULL; -- Invalid accountType
    END IF;

END $$

DELIMITER ;

# USER

CREATE USER 'book_reader'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON bookshelf.books TO 'book_reader'@'localhost'; 
FLUSH PRIVILEGES;



GRANT EXECUTE ON FUNCTION bookshelf.login_check TO 'book_reader'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'Admin'@'localhost' IDENTIFIED BY 'passwordAdmin';
GRANT ALL PRIVILEGES ON *.* TO 'Admin'@'localhost';
FLUSH PRIVILEGES;

ALTER TABLE accounts ADD COLUMN sessionKey VARCHAR(255);
ALTER TABLE books ADD COLUMN isDeleted INT DEFAULT 0;
ALTER TABLE accounts ADD COLUMN isDeleted INT DEFAULT 0;

ALTER TABLE accounts ADD COLUMN sessionKeyExpiration DATETIME;

# DROP PROCEDURE login_check;
DELIMITER $$

CREATE PROCEDURE login_check(
    IN p_username VARCHAR(255), 
    IN p_password VARCHAR(255),
    OUT out_userName VARCHAR(255),
    OUT out_password VARCHAR(255),
    OUT out_sessionKey VARCHAR(255)
)
BEGIN
    DECLARE v_accountType VARCHAR(5);
    DECLARE v_sessionKey VARCHAR(255);

    SELECT accountType INTO v_accountType
    FROM accounts
    WHERE accountUserName = p_username 
      AND accountPassword = p_password;

    IF v_accountType IS NULL THEN
        SET out_userName = NULL;
        SET out_password = NULL;
        SET out_sessionKey = NULL;
    ELSE
        SET v_sessionKey = UUID(); 

        UPDATE accounts
        SET sessionKey = v_sessionKey
        WHERE accountUserName = p_username;

        IF v_accountType = 'User' THEN
            SET out_userName = 'User';
            SET out_password = 'passwordUser';
            SET out_sessionKey = v_sessionKey;
        ELSEIF v_accountType = 'Admin' THEN
            SET out_userName = 'Admin';
            SET out_password = 'passwordAdmin';
            SET out_sessionKey = v_sessionKey;
        ELSE
            SET out_userName = NULL;
            SET out_password = NULL;
            SET out_sessionKey = NULL;
        END IF;
    END IF;
END $$

DELIMITER ;

GRANT EXECUTE ON PROCEDURE bookshelf.login_check TO 'book_reader'@'localhost';
FLUSH PRIVILEGES;

DELIMITER $$

CREATE FUNCTION check_book_availability(p_username VARCHAR(255), p_sessionKey VARCHAR(255), p_bookId INT) 
RETURNS BOOLEAN 
DETERMINISTIC
BEGIN
    IF validate_session(p_username, p_sessionKey) THEN
        -- Add logic to check book availability here
        RETURN TRUE; -- Book is available (example)
    ELSE
        RETURN FALSE; -- Invalid session key
    END IF;

END $$

DELIMITER ;

select accountID from accounts where accountUserName = 'olivia_miller';

INSERT INTO loans (accountID, bookID, loanDate, loanDueDate)
SELECT 
    a.accountID, 
    b.bookID, 
    CURRENT_DATE(), 
    DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)
FROM 
    accounts a
JOIN 
    books b ON b.bookTitle = 'Harry Potter and the Goblet of Fire'
WHERE 
    a.accountUserName = 'olivia_miller';
    
    CREATE USER 'User'@'localhost' IDENTIFIED BY 'passwordUser';
    GRANT ALL PRIVILEGES ON bookshelf.* TO 'User'@'localhost';
    FLUSH PRIVILEGES;
