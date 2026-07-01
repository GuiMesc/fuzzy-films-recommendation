--
-- PostgreSQL database dump
--

\restrict DghNUhACGMQgmgdOxfuHngdQzz4efxg3apmJpt8zBBUTOLfkun1JlwF2Q8yaqZp

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: tbl_actors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_actors (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.tbl_actors OWNER TO postgres;

--
-- Name: tbl_actors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tbl_actors ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbl_actors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tbl_directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_directors (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.tbl_directors OWNER TO postgres;

--
-- Name: tbl_directors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tbl_directors ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbl_directors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tbl_genders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_genders (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.tbl_genders OWNER TO postgres;

--
-- Name: tbl_genders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tbl_genders ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbl_genders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tbl_historic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_historic (
    user_id bigint NOT NULL,
    movie_id bigint NOT NULL,
    minutes_watched integer NOT NULL,
    user_average double precision,
    liked boolean DEFAULT false NOT NULL
);


ALTER TABLE public.tbl_historic OWNER TO postgres;

--
-- Name: tbl_movie_actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_movie_actor (
    movie_id bigint NOT NULL,
    actor_id bigint NOT NULL
);


ALTER TABLE public.tbl_movie_actor OWNER TO postgres;

--
-- Name: tbl_movie_director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_movie_director (
    movie_id bigint NOT NULL,
    director_id bigint NOT NULL
);


ALTER TABLE public.tbl_movie_director OWNER TO postgres;

--
-- Name: tbl_movie_gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_movie_gender (
    movie_id bigint NOT NULL,
    gender_id bigint NOT NULL
);


ALTER TABLE public.tbl_movie_gender OWNER TO postgres;

--
-- Name: tbl_movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_movies (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    duration integer NOT NULL,
    released_year integer DEFAULT 0 NOT NULL,
    average double precision DEFAULT 0 NOT NULL,
    rating_id bigint NOT NULL
);


ALTER TABLE public.tbl_movies OWNER TO postgres;

--
-- Name: tbl_movies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tbl_movies ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbl_movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tbl_ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_ratings (
    id bigint NOT NULL,
    description character varying(255) NOT NULL
);


ALTER TABLE public.tbl_ratings OWNER TO postgres;

--
-- Name: tbl_ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tbl_ratings ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbl_ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tbl_recommendations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_recommendations (
    user_id bigint NOT NULL,
    movie_id bigint NOT NULL,
    recommendation_score double precision
);


ALTER TABLE public.tbl_recommendations OWNER TO postgres;

--
-- Name: tbl_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    favorite_actor_id bigint,
    favorite_director_id bigint,
    favorite_gender_id bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.tbl_users OWNER TO postgres;

--
-- Name: tbl_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tbl_users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbl_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: tbl_actors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_actors (id, name) FROM stdin;
1	Tim Robbins
2	Morgan Freeman
3	Marlon Brando
4	Al Pacino
5	Christian Bale
6	Heath Ledger
7	Robert De Niro
8	Henry Fonda
9	Lee J. Cobb
10	Elijah Wood
11	Viggo Mortensen
12	John Travolta
13	Uma Thurman
14	Liam Neeson
15	Ralph Fiennes
16	Leonardo DiCaprio
17	Joseph Gordon-Levitt
18	Brad Pitt
19	Edward Norton
20	Ian McKellen
21	Tom Hanks
22	Robin Wright
23	Clint Eastwood
24	Eli Wallach
25	Lilly Wachowski
26	Keanu Reeves
27	Ray Liotta
28	Mark Hamill
29	Harrison Ford
30	Jack Nicholson
31	Louise Fletcher
32	Lin-Manuel Miranda
33	Phillipa Soo
34	Kang-ho Song
35	Lee Sun-kyun
36	Suriya
37	Madhavan
38	Matthew McConaughey
39	Anne Hathaway
40	Kátia Lund
41	Alexandre Rodrigues
42	Daveigh Chase
43	Suzanne Pleshette
44	Matt Damon
45	Michael Clarke Duncan
46	Roberto Benigni
47	Nicoletta Braschi
48	Jodie Foster
49	Anthony Hopkins
50	Tatsuya Nakadai
51	Akira Ishihama
52	Toshirô Mifune
53	Takashi Shimura
54	James Stewart
55	Donna Reed
56	Joaquin Phoenix
57	Miles Teller
58	J.K. Simmons
59	Éric Toledano
60	François Cluzet
61	Hugh Jackman
62	Adrien Brody
63	Thomas Kretschmann
64	Russell Crowe
65	Edward Furlong
66	Kevin Spacey
67	Gabriel Byrne
68	Jean Reno
69	Gary Oldman
70	Rob Minkoff
71	Matthew Broderick
72	Arnold Schwarzenegger
73	Linda Hamilton
74	Philippe Noiret
75	Enzo Cannavale
76	Tsutomu Tatsumi
77	Ayano Shiraishi
78	Michael J. Fox
79	Christopher Lloyd
80	Charles Bronson
81	Anthony Perkins
82	Janet Leigh
83	Humphrey Bogart
84	Ingrid Bergman
85	Charles Chaplin
86	Paulette Goddard
87	Virginia Cherrill
88	Zain Al Rafeea
89	Yordanos Shiferaw
90	Erdem Can
91	Çetin Tekindor
92	Pushkar
93	Ryûnosuke Kamiki
94	Mone Kamishiraishi
95	Aamir Khan
96	Sakshi Tanwar
97	Peter Ramsey
98	Rodney Rothman
99	Joe Russo
100	Robert Downey Jr.
101	Adrian Molina
102	Anthony Gonzalez
103	Jamie Foxx
104	Christoph Waltz
105	Tom Hardy
106	Amole Gupte
107	Darsheel Safary
108	Ben Burtt
109	Elissa Knight
110	Ulrich Mühe
111	Martina Gedeck
112	Choi Min-sik
113	Yoo Ji-Tae
114	Guy Pearce
115	Carrie-Anne Moss
116	Yôji Matsuda
117	Yuriko Ishida
118	James Woods
119	Karen Allen
120	Shelley Duvall
121	Martin Sheen
122	Sigourney Weaver
123	Tom Skerritt
124	Rajesh Khanna
125	Amitabh Bachchan
126	Yutaka Sada
127	Peter Sellers
128	George C. Scott
129	Tyrone Power
130	Marlene Dietrich
131	Kirk Douglas
132	Ralph Meeker
133	Grace Kelly
134	William Holden
135	Gloria Swanson
136	Dean-Charles Chapman
137	George MacKay
138	Anand Gandhi
139	Adesh Prasad
140	Ayushmann Khurrana
141	Tabu
142	Mohanlal
143	Meena
144	Mads Mikkelsen
145	Thomas Bo Larsen
146	Payman Maadi
147	Leila Hatami
148	Lubna Azabal
149	Mélissa Désormeaux-Poulin
150	Aras Bulut Iynemli
151	Nisa Sofiya Aksongur
152	Fikret Kuskan
153	Diane Kruger
154	Jim Carrey
155	Kate Winslet
156	Audrey Tautou
157	Mathieu Kassovitz
158	Jason Statham
159	Ellen Burstyn
160	Jared Leto
161	Annette Bening
162	Robin Williams
163	Mohammad Amir Naji
164	Amir Farrokh Hashemian
165	Tim Allen
166	Mel Gibson
167	Sophie Marceau
168	Harvey Keitel
169	Tim Roth
170	Matthew Modine
171	R. Lee Ermey
172	Aleksey Kravchenko
173	Olga Mironova
174	Michael Biehn
175	F. Murray Abraham
176	Tom Hulce
177	Michelle Pfeiffer
178	Jürgen Prochnow
179	Herbert Grönemeyer
180	Paul Newman
181	Robert Redford
182	Malcolm McDowell
183	Patrick Magee
184	Keir Dullea
185	Gary Lockwood
186	Lee Van Cleef
187	Peter O'Toole
188	Alec Guinness
189	Jack Lemmon
190	Shirley MacLaine
191	Cary Grant
192	Eva Marie Saint
193	Kim Novak
194	Gene Kelly
195	Nobuo Kaneko
196	Lamberto Maggiorani
197	Enzo Staiola
198	Fred MacMurray
199	Barbara Stanwyck
200	Orson Welles
201	Joseph Cotten
202	Peter Lorre
203	Ellen Widmann
204	Brigitte Helm
205	Alfred Abel
206	Edna Purviance
207	Sushant Singh Rajput
208	Shraddha Kapoor
209	Vicky Kaushal
210	Paresh Rawal
211	Yash
212	Srinidhi Shetty
213	Mahershala Ali
214	Frances McDormand
215	Woody Harrelson
216	Irrfan Khan
217	Konkona Sen Sharma
218	Prabhas
219	Rana Daggubati
220	Carlos Martínez López
221	Jason Schwartzman
222	Kangana Ranaut
223	Rajkummar Rao
224	Lembit Ulfsak
225	Elmo Nüganen
226	Farhan Akhtar
227	Sonam Kapoor
228	Manoj Bajpayee
229	Richa Chadha
230	Rajat Barmecha
231	Ronit Roy
232	Mahie Gill
233	Ricardo Darín
234	Soledad Villamil
235	Nick Nolte
236	Emily Mortimer
237	Bob Peterson
238	Edward Asner
239	Jonah Hill
240	Shah Rukh Khan
241	Vidya Malvade
242	Daniel Day-Lewis
243	Paul Dano
244	Ivana Baquero
245	Ariadna Gil
246	Hugo Weaving
247	Natalie Portman
248	Soha Ali Khan
249	Rani Mukerji
250	Michael Caine
251	Gayatri Joshi
252	Bruno Ganz
253	Alexandra Maria Lara
254	Chieko Baishô
255	Takuya Kimura
256	Ed Harris
257	Akshay Kumar
258	Sunil Shetty
259	Jason Flemyng
260	Dexter Fletcher
261	Sener Sen
262	Ugur Yücel
263	Sharon Stone
264	Salman Khan
265	Gene Hackman
266	Sean Connery
267	Davor Dujmovic
268	Bora Todorovic
269	Hitoshi Takagi
270	Noriko Hidaka
271	Bruce Willis
272	Alan Rickman
273	Akira Terao
274	Cathy Moriarty
275	Alisa Freyndlikh
276	Aleksandr Kaydanovskiy
277	Liv Ullmann
278	Anthony Quinn
279	Irene Papas
280	Sanjeev Kumar
281	Dharmendra
282	Terry Jones
283	Graham Chapman
284	Steve McQueen
285	James Garner
286	Gregory Peck
287	John Megna
288	Eijirô Tôno
289	Spencer Tracy
290	Burt Lancaster
291	Marilyn Monroe
292	Tony Curtis
293	Victor Sjöström
294	Bibi Andersson
295	Max von Sydow
296	Gunnar Björnstrand
297	Jean Servais
298	Carl Möhner
299	Ray Milland
300	Chishû Ryû
301	Chieko Higashiyama
302	Machiko Kyô
303	Bette Davis
304	Anne Baxter
305	Walter Huston
306	Carole Lombard
307	Jack Benny
308	Mack Swain
309	Buster Keaton
310	Kathryn McGuire
311	Noémie Merlant
312	Adèle Haenel
313	Taapsee Pannu
314	Miyu Irino
315	Saori Hayami
316	Mario Casas
317	Ana Wagener
318	Kim Min-hee
319	Jung-woo Ha
320	Anne Dorval
321	Antoine Olivier Pilon
322	Shahid Kapoor
323	Patrick Stewart
324	Brie Larson
325	Jacob Tremblay
326	Darío Grandinetti
327	María Marull
328	Kemp Powers
329	Haluk Bilginer
330	Melisa Sözen
331	Anushka Sharma
332	Ben Affleck
333	Rosamund Pike
334	Aoi Miyazaki
335	Takao Osawa
336	Andrew Garfield
337	Sam Worthington
338	Ronnie Del Carmen
339	Amy Poehler
340	Ranbir Kapoor
341	Priyanka Chopra
342	Chiwetel Ejiofor
343	Michael Kenneth Williams
344	Daniel Brühl
345	Chris Hemsworth
346	Mark Ruffalo
347	Michael Keaton
348	David Rawle
349	Brendan Gleeson
350	Vidya Balan
351	Parambrata Chattopadhyay
352	Hrithik Roshan
353	Jake Gyllenhaal
354	Charlize Theron
355	Anupam Kher
356	Naseeruddin Shah
357	Bee Vang
358	Daniel Radcliffe
359	Emma Watson
360	Masahiro Motoki
361	Ryôko Hirosue
362	Richard Gere
363	Joan Allen
364	Toni Collette
365	Philip Seymour Hoffman
366	Chris Sanders
367	Jay Baruchel
368	Emile Hirsch
369	Vince Vaughn
370	Joel Coen
371	Tommy Lee Jones
372	Sanjay Dutt
373	Arshad Warsi
374	Hilary Swank
375	Don Cheadle
376	Sophie Okonedo
377	Jang Dong-Gun
378	Won Bin
379	Ethan Hawke
380	Julie Delpy
381	Kim Sang-kyung
382	Saif Ali Khan
383	David Carradine
384	Lee Unkrich
385	Albert Brooks
386	Emilio Echevarría
387	Gael García Bernal
388	David Silverman
389	Kazuya Tsurumaki
390	Megumi Ogata
391	Raghuvir Yadav
392	Haley Joel Osment
393	Pruitt Taylor Vince
394	Bajram Severdzan
395	Srdjan 'Zika' Todorovic
396	Ethan Coen
397	Jeff Bridges
398	Tony Chiu-Wai Leung
399	Maggie Cheung
400	Ewan McGregor
401	Ewen Bremner
402	William H. Macy
403	Predrag 'Miki' Manojlovic
404	Lazar Ristovski
405	Vincent Cassel
406	Hubert Koundé
407	Kajol
408	Irène Jacob
409	Jean-Louis Trintignant
410	Brigitte Lin
411	Takeshi Kaneshiro
412	Sam Neill
413	Laura Dern
414	Pete Postlethwaite
415	Leslie Cheung
416	Fengyi Zhang
417	Gong Li
418	Jingwu Ma
419	Robert Sean Leonard
420	Wil Wheaton
421	River Phoenix
422	Charlie Sheen
423	Tom Berenger
424	Harry Dean Stanton
425	Nastassja Kinski
426	Sumi Shimamoto
427	Mahito Tsujimura
428	Kurt Russell
429	Wilford Brimley
430	Bob Geldof
431	Christine Hargreaves
432	Klaus Kinski
433	Claudia Cardinale
434	Bertil Guve
435	Pernilla Allwin
436	Rutger Hauer
437	John Hurt
438	John Cleese
439	Christopher Walken
440	Sylvester Stallone
441	Talia Shire
442	Faye Dunaway
443	Ryan O'Neal
444	Marisa Berenson
445	Margarita Terekhova
446	Filipp Yankovskiy
447	Tatum O'Neal
448	Harriet Andersson
449	Natalya Bondarchuk
450	Donatas Banionis
451	Alain Delon
452	François Périer
453	George Kennedy
454	Anatoliy Solonitsyn
455	Ivan Lapikov
456	Brahim Hadjadj
457	Jean Martin
458	Silvia Pinal
459	Jacqueline Andere
460	Joan Crawford
461	John Wayne
462	Eduard Abalov
463	Nikolay Burlyaev
464	Birgitta Valberg
465	Fredric March
466	Jean-Pierre Léaud
467	Albert Rémy
468	Charlton Heston
469	Jack Hawkins
470	Misa Uehara
471	Giulietta Masina
472	Minoru Chiaki
473	Karl Malden
474	Yves Montand
475	Charles Vanel
476	Jan Sterling
477	James Cagney
478	Virginia Mayo
479	Emeric Pressburger
480	Anton Walbrook
481	Margaret Sullavan
482	Laurence Olivier
483	Joan Fontaine
484	Jean Arthur
485	George Cukor
486	Sam Wood
487	Jean Gabin
488	Dita Parlo
489	Clark Gable
490	Claudette Colbert
491	Maria Falconetti
492	Eugene Silvain
493	Merna Kennedy
494	George O'Brien
495	Janet Gaynor
496	Werner Krauss
497	Conrad Veidt
498	Neena Gupta
499	Willem Dafoe
500	Julianne Nicholson
501	Nimrat Kaur
502	Harshaali Malhotra
503	Danny Denzongpa
504	Ryan Gosling
505	Emma Stone
506	Dev Patel
507	Nicole Kidman
508	Jessica Chastain
509	Rich Moore
510	Jared Bush
511	Chloë Grace Moretz
512	James Caan
513	Owen Wilson
514	Vijay Varma
515	Nakul Roshan Sahdev
516	Frantz Turner
517	Iko Uwais
518	Yayan Ruhian
519	Benedict Cumberbatch
520	Keira Knightley
521	Chris Pratt
522	Vin Diesel
523	Amy Adams
524	Rami Malek
525	Lucy Boynton
526	Logan Lerman
527	Wagner Moura
528	Irandhir Santos
529	Colin Firth
530	Geoffrey Rush
531	Viola Davis
532	Ryan Reynolds
533	Morena Baccarin
534	Golshifteh Farahani
535	Shahab Hosseini
536	Abhay Deol
537	Donnie Yen
538	Simon Yam
539	Mete Horozoglu
540	Loveleen Tandan
541	Mila Kunis
542	André Ramiro
543	Chris Evans
544	Marjane Satrapi
545	Chiara Mastroianni
546	Jennifer Garner
547	Will Smith
548	Thandie Newton
549	Djimon Hounsou
550	Edgar Ramírez
551	Seung-Yun Lee
552	Hee Jae
553	Quentin Tarantino
554	Robert Rodriguez
555	Laura Obiols
556	Mathieu Amalric
557	Cem Yilmaz
558	Özge Özberk
559	Jan Pinkava
560	Brad Garrett
561	Daniel Craig
562	Eva Green
563	Vladimir Garin
564	Ivan Dobronravov
565	Ki-duk Kim
566	Yeong-su Oh
567	Javier Bardem
568	Belén Rueda
569	Renée Zellweger
570	Preity Zinta
571	Alan Mak
572	Andy Lau
573	Johnny Depp
574	Albert Finney
575	Craig T. Nelson
576	Samuel L. Jackson
577	Tae-Hyun Cha
578	Jun Ji-Hyun
579	Paul Bettany
580	Ömer Faruk Sorak
581	Yilmaz Erdogan
582	Jena Malone
583	Tom Cruise
584	Jason Robards
585	Björk
586	Catherine Deneuve
587	Richard Farnsworth
588	Sissy Spacek
589	Junko Iwao
590	Rica Matsumoto
591	Ulrich Thomsen
592	Henning Moritzen
593	Fernanda Montenegro
594	Vinícius de Oliveira
595	Eli Marienthal
596	Harry Connick Jr.
597	Til Schweiger
598	Jan Josef Liefers
599	Billy Bob Thornton
600	Dwight Yoakam
601	Timothy Spall
602	Brenda Blethyn
603	Madeleine Stowe
604	Atsuko Tanaka
605	Iemasa Kayumi
606	Danny Elfman
607	Chris Sarandon
608	Bill Murray
609	Andie MacDowell
610	Damian Chapa
611	Jesse Borrego
612	Chris O'Donnell
613	John Musker
614	Scott Weinger
615	Kevin Costner
616	Kirk Wise
617	Paige O'Hara
618	Mary McDonnell
619	Danny Aiello
620	Ossie Davis
621	Dustin Hoffman
622	Mitsuo Iwata
623	Nozomu Sasaki
624	Cary Elwes
625	Mandy Patinkin
626	Solveig Dommartin
627	Gaspard Manesse
628	Raphael Fejtö
629	Mayumi Tanaka
630	Keiko Yokozawa
631	Ben Kingsley
632	John Gielgud
633	Tsutomu Yamazaki
634	Woody Allen
635	Diane Keaton
636	Roy Scheider
637	Robert Shaw
638	John Cazale
639	Gene Wilder
640	Madeline Kahn
641	Timothy Bottoms
642	Topol
643	Norma Crane
644	Stefania Sandrelli
645	Mia Farrow
646	John Cassavetes
647	Roddy McDowall
648	Anne Bancroft
649	Elizabeth Taylor
650	Richard Burton
651	Julie Andrews
652	Christopher Plummer
653	Omar Sharif
654	Julie Christie
655	Gian Maria Volontè
656	Marcello Mastroianni
657	Anouk Aimée
658	Anna Karina
659	Sady Rebbot
660	Jackie Gleason
661	Anita Ekberg
662	Dean Martin
663	Lee Remick
664	Sterling Hayden
665	Coleen Gray
666	Robert Mitchum
667	Shelley Winters
668	Simone Signoret
669	Véra Clouzot
670	Don Taylor
671	Audrey Hepburn
672	Vivien Leigh
673	Gloria Grahame
674	Dennis Price
675	John Dall
676	Jane Greer
677	Celia Johnson
678	Trevor Howard
679	Gene Tierney
680	Dana Andrews
681	Myrna Loy
682	Priscilla Lane
683	Mary Astor
684	Jane Darwell
685	Mervyn LeRoy
686	Marcel Dalio
687	Nora Gregor
688	William Powell
689	Lew Ayres
690	Louis Wolheim
691	Aleksandr Antonov
692	Vladimir Barskiy
693	Sanjana Sanghi
694	Lily Franky
695	Sakura Andô
696	Adam Driver
697	Scarlett Johansson
698	Armie Hammer
699	Timothée Chalamet
700	Dave Johns
701	Bryan Cranston
702	Koyu Rankin
703	Julian Dennison
704	Ferdia Walsh-Peelo
705	Aidan Gillen
706	Tom Hiddleston
707	Rene Russo
708	Roman Griffin Davis
709	Thomasin McKenzie
710	Jeremy Renner
711	Daisy Ridley
712	John Boyega
713	Muhammet Uzuner
714	Jean Dujardin
715	Bérénice Bejo
716	Emily Blunt
717	Emmanuelle Riva
718	Tahar Rahim
719	Niels Arestrup
720	Sam Rockwell
721	Kåre Hedebrant
722	Lina Leandersson
723	Sharlto Copley
724	David James
725	Mickey Rourke
726	Marisa Tomei
727	Kareena Kapoor
728	Ellar Coltrane
729	Patricia Arquette
730	Anamaria Marinca
731	Laura Vasiliu
732	Chris Pine
733	Zachary Quinto
734	Colin Farrell
735	David Lee Smith
736	Tony Todd
737	Ken Watanabe
738	Kazunari Ninomiya
739	Lee Pace
740	Catinca Untaru
741	Suraj Sharma
742	George Clooney
743	Meryl Streep
744	Michel Côté
745	Marc-André Grondin
746	Gérard Jugnot
747	François Berléand
748	Gwyneth Paltrow
749	Simon Pegg
750	Nick Frost
751	Birol Ünel
752	Sibel Kekilli
753	Sean Penn
754	Jet Li
755	Rosario Flores
756	Javier Cámara
757	Branko Djuric
758	Rene Bitorajac
759	Tensai Okamura
760	Hiroyuki Okiura
761	Franka Potente
762	Gastón Pauls
763	Julianne Moore
764	Clive Owen
765	Billy Crudup
766	Patrick Fugit
767	Naomi Watts
768	Laura Harring
769	Ash Brannon
770	Mark Wahlberg
771	Yoko Honna
772	Issey Takahashi
773	Rena Owen
774	Temuera Morrison
775	Christian Slater
776	Juliette Binoche
777	Zbigniew Zamachowski
778	Kôichi Yamadera
779	Emi Shinohara
780	Winona Ryder
781	Brenda Fricker
782	Martin Landau
783	Dianne Wiest
784	Jonathan Pryce
785	Kim Greist
786	Rob Reiner
787	Michael McKean
788	Peter Billingsley
789	Melinda Dillon
790	John Belushi
791	Dan Aykroyd
792	Jessica Lange
793	David Emge
794	Ken Foree
795	Alejandro Jodorowsky
796	Horacio Salinas
797	Magali Noël
798	Bruno Zanin
799	Fernando Rey
800	Delphine Seyrig
801	Ruy Guerra
802	Ruth Gordon
803	Bud Cort
804	Ernest Borgnine
805	Duane Jones
806	Judith O'Dea
807	Katharine Hepburn
808	Sidney Poitier
809	Rod Steiger
810	Frank Sinatra
811	Laurence Harvey
812	Gabriele Ferzetti
813	Monica Vitti
814	Eiji Okada
815	Yul Brynner
816	Jeffrey Hunter
817	James Dean
818	Raymond Massey
819	Gary Cooper
820	Farley Granger
821	Robert Walker
822	Wallace Ford
823	Edmund Gwenn
824	Maureen O'Hara
825	Lauren Bacall
826	Jane Wyman
827	Rosalind Russell
828	William Keighley
829	Errol Flynn
830	Edmund Goulding
831	Groucho Marx
832	Ernest B. Schoedsack
833	Fay Wray
834	Leila Hyams
835	Max Schreck
836	Alexander Granach
837	Charlie Hunnam
838	Alia Bhatt
839	Riz Ahmed
840	Olivia Cooke
841	Taraneh Alidoosti
842	Fionn Whitehead
843	Barry Keoghan
844	Giuseppe Battiston
845	Anna Foglietta
846	Taraji P. Henson
847	Octavia Spencer
848	Ben Whishaw
849	Hugh Grant
850	Art Parkinson
851	Kiara Advani
852	Casey Affleck
853	Michelle Williams
854	Roland Møller
855	Louis Hofmann
856	Felicity Jones
857	Diego Luna
858	Saoirse Ronan
859	Hugh Welchman
860	Douglas Booth
861	Bill Nighy
862	Imelda Staunton
863	Toni Servillo
864	Carlo Verdone
865	Yami Gautam
866	Chris Williams
867	Ryan Potter
868	Domhnall Gleeson
869	Rachel McAdams
870	Sridevi
871	Adil Hussain
872	Hideaki Anno
873	Hidetoshi Nishijima
874	Jim Sturgess
875	Jared Gilman
876	Kara Hayward
877	Cate Blanchett
878	Steve Carell
879	Takako Matsu
880	Yoshino Kimura
881	Lee Byung-Hun
882	Rooney Mara
883	Barkhad Abdi
884	Sae-ron Kim
885	O'Shea Jackson Jr.
886	Corey Hawkins
887	Hye-ja Kim
888	Kim Yoon-seok
889	Martin Freeman
890	Christian Friedel
891	Ernst Jacobi
892	Michael Nyqvist
893	Noomi Rapace
894	Eddie Redmayne
895	Alex Sharp
896	Maggie Grace
897	Asa Butterfield
898	David Thewlis
899	Glen Hansard
900	Markéta Irglová
901	Baki Davrak
902	Nurgül Yesilçay
903	James McAvoy
904	Carey Mulligan
905	Denzel Washington
906	Zoe Saldana
907	Sarah Polley
908	Gerardo Taracena
909	Raoul Max Trujillo
910	Valerie Faris
911	Matthew Macfadyen
912	Diane Ladd
913	Shôgo Furuya
914	Tôru Emori
915	Nathan Fillion
916	Gina Torres
917	Reese Witherspoon
918	Andreas Wilson
919	Henrik Lundström
920	Gena Rowlands
921	Rodrigo De la Serna
922	Oksana Akinshina
923	Artyom Bogucharskiy
924	Michèle Caucheteux
925	Jean-Claude Donda
926	Lee Yeong-ae
927	Jim Caviezel
928	Trevor Jack Brooks
929	Will Patton
930	Yun-Fat Chow
931	Michelle Yeoh
932	Cecilia Roth
933	Marisa Paredes
934	Helen Hunt
935	Sean Patrick Flanery
936	Chris Cooper
937	Vicky Jenson
938	Mike Myers
939	Takeshi Kitano
940	Kayoko Kishimoto
941	Michael Douglas
942	Deborah Kara Unger
943	Emily Watson
944	Stellan Skarsgård
945	Kevin Jarre
946	Tom Guiry
947	Mike Vitar
948	Emma Thompson
949	Lesley Sharp
950	Chazz Palminteri
951	Boyd Kirkland
952	Frank Paur
953	Wladyslaw Kowalski
954	Cuba Gooding Jr.
955	Laurence Fishburne
956	Kathy Bates
957	Kirsten Dunst
958	Minami Takayama
959	Danny Lee
960	Carl Weathers
961	Bruce Campbell
962	Sarah Berry
963	Alan Ruck
964	Tom Waits
965	John Lurie
966	Sean Astin
967	Josh Brolin
968	Danny Glover
969	Whoopi Goldberg
970	Emilio Estevez
971	Judd Nelson
972	Sam Waterston
973	Haing S. Ngor
974	Sam Shepard
975	Scott Glenn
976	Jerry Lewis
977	Henry Thomas
978	Drew Barrymore
979	Brooke Adams
980	Sondra Locke
981	Barry Bostwick
982	Jennifer Drake
983	Edward Fox
984	Terence Alexander
985	Liza Minnelli
986	Michael York
987	Jack Albertson
988	Jon Voight
989	Alan Arkin
990	Warren Beatty
991	Rex Harrison
992	Dick Van Dyke
993	Andrew Marton
994	Gerd Oswald
995	Jeanne Moreau
996	Oskar Werner
997	Deborah Kerr
998	Peter Wyngarde
999	Jean-Paul Belmondo
1000	Jean Seberg
1001	Arthur Rosson
1002	Edward G. Robinson
1003	Teresa Wright
1004	Claire Trevor
1005	Margaret Lockwood
1006	Michael Redgrave
1007	Boris Karloff
1008	Elsa Lanchester
1009	Harpo Marx
1010	Richard Rosson
1011	Paul Muni
1012	Colin Clive
1013	Mae Clarke
1014	Yalitza Aparicio
1015	Marina de Tavira
1016	Josh O'Connor
1017	Alec Secareanu
1018	Kelsey Asbille
1019	Daniel Kaluuya
1020	Allison Williams
1021	Henry Cavill
1022	Rolf Lassgård
1023	Bahar Pars
1024	Taika Waititi
1025	Jemaine Clement
1026	Hiromasa Yonebayashi
1027	Sara Takatsuki
1028	Taron Egerton
1029	Shailene Woodley
1030	Ansel Elgort
1031	Thomas Mann
1032	RJ Cyler
1033	Zach Galifianakis
1034	Léa Seydoux
1035	Adèle Exarchopoulos
1036	Amit Sadh
1037	Veerle Baetens
1038	Johan Heldenbergh
1039	Nargis Fakhri
1040	Bruce Dern
1041	Will Forte
1042	John C. Reilly
1043	Jack McBrayer
1044	Mackenzie Foy
1045	Christina Hendricks
1046	Phil Lord
1047	Sandra Bullock
1048	Abraham Attah
1049	Emmanuel Affadzi
1050	Jesse Eisenberg
1051	Michael Fassbender
1052	Bradley Cooper
1053	Jennifer Lawrence
1054	Zooey Deschanel
1055	Frank Langella
1056	Michael Sheen
1057	Megumi Hayashibara
1058	Angelina Jolie
1059	Colm Feore
1060	Madeline Carroll
1061	Callan McAuliffe
1062	Riisa Naka
1063	Takuya Ishida
1064	Tatsuya Fujiwara
1065	Ken'ichi Matsuyama
1066	Thomas Turgoose
1067	Stephen Graham
1068	Alicia Vikander
1069	Sidse Babett Knudsen
1070	Forest Whitaker
1071	Josh Hartnett
1072	Benno Fürmann
1073	Sam Riley
1074	Samantha Morton
1075	Byron Howard
1076	Mandy Moore
1077	Carice van Houten
1078	Sebastian Koch
1079	Stephen Chow
1080	Wah Yuen
1081	Jennifer Jason Leigh
1082	Regina King
1083	Dakota Fanning
1084	Teri Hatcher
1085	Eileen Walsh
1086	Dorothy Duffy
1087	Katrin Saß
1088	Paddy Considine
1089	Nicolas Cage
1090	Tyler Hoechlin
1091	Moritz Bleibtreu
1092	Christian Berkel
1093	Jamie Bell
1094	Julie Walters
1095	John Cameron Mitchell
1096	Miriam Shor
1097	Andrew Philpot
1098	John Rafter Lee
1099	James Marsden
1100	Trey Parker
1101	Matt Stone
1102	Ron Livingston
1103	Jennifer Aniston
1104	Jane Adams
1105	Jon Lovitz
1106	Eduardo Noriega
1107	Penélope Cruz
1108	John Cusack
1109	Cameron Diaz
1110	Milla Jovovich
1111	Thierry Lhermitte
1112	Jacques Villeret
1113	Armin Mueller-Stahl
1114	Laura Linney
1115	Kenneth Branagh
1116	Liesel Matthews
1117	Eleanor Bron
1118	Leon Lai
1119	Michelle Reis
1120	Massimo Troisi
1121	Brian O'Halloran
1122	Jeff Anderson
1123	Kermit the Frog
1124	Angela Bassett
1125	Shûichirô Moriyama
1126	Tokiko Katô
1127	Jessica Tandy
1128	John Turturro
1129	Bob Hoskins
1130	Bernard-Pierre Donnadieu
1131	Gene Bervoets
1132	Richard E. Grant
1133	Paul McGann
1134	John Lone
1135	Joan Chen
1136	John Malkovich
1137	Isabella Rossellini
1138	Kyle MacLachlan
1139	Jeff Daniels
1140	Griffin Dunne
1141	Rosanna Arquette
1142	Charlotte Rampling
1143	William Shatner
1144	Leonard Nimoy
1145	Brian Dennehy
1146	Donald Sutherland
1147	Mary Tyler Moore
1148	David Zucker
1149	Jerry Zucker
1150	Yasuo Yamada
1151	Eiko Masuyama
1152	Donald Pleasence
1153	Jamie Lee Curtis
1154	Roman Polanski
1155	Isabelle Adjani
1156	Walter Matthau
1157	Cleavon Little
1158	John Randolph
1159	Bruce Lee
1160	John Saxon
1161	Burt Reynolds
1162	Andrew Robinson
1163	Lee Marvin
1164	Jean Sorel
1165	Paul Scofield
1166	Wendy Hiller
1167	Ian Hendry
1168	Stanley Baker
1169	Gert Fröbe
1170	Rod Taylor
1171	Tippi Hedren
1172	Karlheinz Böhm
1173	Anna Massey
1174	Pierre Brasseur
1175	Alida Valli
1176	Kevin McCarthy
1177	Dana Wynter
1178	Natalie Wood
1179	Michael Rennie
1180	Patricia Neal
1181	Rita Hayworth
1182	Glenn Ford
1183	Samuel Armstrong
1184	Ford Beebe Jr.
1185	Claude Rains
1186	Gloria Stuart
1187	John Cho
1188	Debra Messing
1189	Maryana Spivak
1190	Aleksey Rozin
1191	Brooklynn Prince
1192	Bria Vinaite
1193	Michael B. Jordan
1194	Mckenna Grace
1195	Michael Schwartz
1196	Zack Gottsagen
1197	Laia Costa
1198	Frederick Lau
1199	Günes Sensoy
1200	Doga Zeynep Doguslu
1201	Jon Bernthal
1202	Mark Rylance
1203	Holly Hunter
1204	Don Hall
1205	Aleksey Serebryakov
1206	Elena Lyadova
1207	Ben Foster
1208	Judi Dench
1209	Steve Coogan
1210	Keri Russell
1211	Jose Coronado
1212	Hugo Silva
1213	Ananda George
1214	Michael Peña
1215	Mirai Shida
1216	Lady Gaga
1217	Mikael Persbrandt
1218	Trine Dyrholm
1219	Chris Renaud
1220	Seth Rogen
1221	Aaron Taylor-Johnson
1222	Luis Tosar
1223	Alberto Ammann
1224	Antonio Banderas
1225	Elena Anaya
1226	Jürgen Vogel
1227	Jude Law
1228	Quinton Aaron
1229	Richard Jenkins
1230	Haaz Sleiman
1231	Rosario Dawson
1232	Charlie Cox
1233	Claire Danes
1234	Nora Twomey
1235	Evan McGuire
1236	Marion Cotillard
1237	Sylvie Testud
1238	Li Sun
1239	Jessica Biel
1240	Gary Stretch
1241	Gerard Butler
1242	Lena Headey
1243	Jonathan Rhys Meyers
1244	Jackie Earle Haley
1245	Patrick Wilson
1246	Leigh Whannell
1247	Brady Corbet
1248	Guillaume Canet
1249	Gaspard Ulliel
1250	Peter Dinklage
1251	Patricia Clarkson
1252	Benicio Del Toro
1253	Shin Ha-kyun
1254	Barry Pepper
1255	J. Mackye Gruber
1256	Ashton Kutcher
1257	Cillian Murphy
1258	Naomie Harris
1259	Aki Maeda
1260	Maribel Verdú
1261	Rupert Grint
1262	Christopher Eccleston
1263	Vicellous Shannon
1264	Justin Theroux
1265	Barry Cook
1266	Ming-Na Wen
1267	Susanne Lothar
1268	Rufus Sewell
1269	Kiefer Sutherland
1270	Kevin Bacon
1271	Bill Pullman
1272	Jeremy Irons
1273	Gary Farmer
1274	Bill Paxton
1275	Robert Duvall
1276	Jason London
1277	Wiley Wiggins
1278	Joe Pesci
1279	Miki Imai
1280	Toshirô Yanagiba
1281	Jean-Pierre Jeunet
1282	Marie-Laure Dougnac
1283	Macaulay Culkin
1284	Billy Crystal
1285	Meg Ryan
1286	Jodi Benson
1287	Leslie Nielsen
1288	Priscilla Presley
1289	Steve Martin
1290	John Candy
1291	John Getz
1292	Bruce Spence
1293	Michael Beck
1294	James Remar
1295	Jim Henson
1296	Frank Oz
1297	Patrick McGoohan
1298	John Hubley
1299	Brad Davis
1300	Irene Miracle
1301	Richard Dreyfuss
1302	François Truffaut
1303	Elliott Gould
1304	Nina van Pallandt
1305	James Coburn
1306	Telly Savalas
1307	Phil Harris
1308	Sebastian Cabot
1309	David Hemmings
1310	Vanessa Redgrave
1311	John Lennon
1312	Paul McCartney
1313	George Peppard
1314	Rock Hudson
1315	Montgomery Clift
1316	Tallulah Bankhead
1317	John Hodiak
1318	Robert Donat
1319	Madeleine Carroll
\.


--
-- Data for Name: tbl_directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_directors (id, name) FROM stdin;
1	Frank Darabont
2	Francis Ford Coppola
3	Christopher Nolan
4	Sidney Lumet
5	Peter Jackson
6	Quentin Tarantino
7	Steven Spielberg
8	David Fincher
9	Robert Zemeckis
10	Sergio Leone
11	Lana Wachowski
12	Martin Scorsese
13	Irvin Kershner
14	Milos Forman
15	Thomas Kail
16	Bong Joon Ho
17	Sudha Kongara
18	Fernando Meirelles
19	Hayao Miyazaki
20	Roberto Benigni
21	Jonathan Demme
22	George Lucas
23	Masaki Kobayashi
24	Akira Kurosawa
25	Frank Capra
26	Todd Phillips
27	Damien Chazelle
28	Olivier Nakache
29	Roman Polanski
30	Ridley Scott
31	Tony Kaye
32	Bryan Singer
33	Luc Besson
34	Roger Allers
35	James Cameron
36	Giuseppe Tornatore
37	Isao Takahata
38	Alfred Hitchcock
39	Michael Curtiz
40	Charles Chaplin
41	Nadine Labaki
42	Can Ulkay
43	Gayatri
44	Makoto Shinkai
45	Nitesh Tiwari
46	Bob Persichetti
47	Anthony Russo
48	Lee Unkrich
49	Rajkumar Hirani
50	Aamir Khan
51	Andrew Stanton
52	Florian Henckel von Donnersmarck
53	Chan-wook Park
54	Stanley Kubrick
55	Hrishikesh Mukherjee
56	Billy Wilder
57	Sam Mendes
58	Rahi Anil Barve
59	Sriram Raghavan
60	Jeethu Joseph
61	Thomas Vinterberg
62	Asghar Farhadi
63	Denis Villeneuve
64	Mehmet Ada Öztekin
65	Çagan Irmak
66	Michel Gondry
67	Jean-Pierre Jeunet
68	Guy Ritchie
69	Darren Aronofsky
70	Gus Van Sant
71	Majid Majidi
72	John Lasseter
73	Mel Gibson
74	Elem Klimov
75	Brian De Palma
76	Richard Marquand
77	Wolfgang Petersen
78	George Roy Hill
79	David Lean
80	Stanley Donen
81	Vittorio De Sica
82	Orson Welles
83	Fritz Lang
84	Aditya Dhar
85	Prashanth Neel
86	Peter Farrelly
87	Martin McDonagh
88	Meghna Gulzar
89	S.S. Rajamouli
90	Sergio Pablos
91	Vikas Bahl
92	Zaza Urushadze
93	Rakeysh Omprakash Mehra
94	Anurag Kashyap
95	Vikramaditya Motwane
96	Tigmanshu Dhulia
97	Juan José Campanella
98	Gavin O'Connor
99	Pete Docter
100	Shimit Amin
101	Paul Thomas Anderson
102	Guillermo del Toro
103	James McTeigue
104	Sanjay Leela Bhansali
105	Ashutosh Gowariker
106	Oliver Hirschbiegel
107	Ron Howard
108	Priyadarshan
109	Curtis Hanson
110	Yavuz Turgul
111	Michael Mann
112	Rajkumar Santoshi
113	Clint Eastwood
114	Emir Kusturica
115	John McTiernan
116	Andrei Tarkovsky
117	Ingmar Bergman
118	Moustapha Akkad
119	Ramesh Sippy
120	Terry Gilliam
121	John Sturges
122	Robert Mulligan
123	Stanley Kramer
124	Jules Dassin
125	Yasujirô Ozu
126	Joseph L. Mankiewicz
127	John Huston
128	Ernst Lubitsch
129	Buster Keaton
130	Céline Sciamma
131	Aniruddha Roy Chowdhury
132	Naoko Yamada
133	Oriol Paulo
134	Xavier Dolan
135	Vishal Bhardwaj
136	James Mangold
137	Lenny Abrahamson
138	Damián Szifron
139	Nuri Bilge Ceylan
140	Umesh Shukla
141	Wes Anderson
142	Mamoru Hosoda
143	Anurag Basu
144	Steve McQueen
145	Tom McCarthy
146	Tomm Moore
147	Sujoy Ghosh
148	Zoya Akhtar
149	George Miller
150	Neeraj Pandey
151	David Yates
152	Yôjirô Takita
153	Lasse Hallström
154	Adam Elliot
155	Dean DeBlois
156	Sean Penn
157	Ethan Coen
158	Terry George
159	Je-kyu Kang
160	Richard Linklater
161	Farhan Akhtar
162	Alejandro G. Iñárritu
163	Hideaki Anno
164	M. Night Shyamalan
165	Peter Weir
166	Joel Coen
167	Kar-Wai Wong
168	Danny Boyle
169	Mathieu Kassovitz
170	Aditya Chopra
171	Krzysztof Kieslowski
172	Jim Sheridan
173	Kaige Chen
174	Yimou Zhang
175	Rob Reiner
176	Oliver Stone
177	Wim Wenders
178	John Carpenter
179	Alan Parker
180	Werner Herzog
181	David Lynch
182	Terry Jones
183	Michael Cimino
184	John G. Avildsen
185	Peter Bogdanovich
186	Jean-Pierre Melville
187	Stuart Rosenberg
188	Gillo Pontecorvo
189	Luis Buñuel
190	Robert Aldrich
191	John Ford
192	François Truffaut
193	William Wyler
194	Federico Fellini
195	Elia Kazan
196	Henri-Georges Clouzot
197	Raoul Walsh
198	Carol Reed
199	Michael Powell
200	Victor Fleming
201	Jean Renoir
202	Carl Theodor Dreyer
203	F.W. Murnau
204	Clyde Bruckman
205	Robert Wiene
206	Amit Ravindernath Sharma
207	Ericson Core
208	Raja Menon
209	Kabir Khan
210	Garth Davis
211	Byron Howard
212	Stephen Chbosky
213	Destin Daniel Cretton
214	Gareth Evans
215	Morten Tyldum
216	James Gunn
217	Spike Jonze
218	José Padilha
219	Tom Hooper
220	Tate Taylor
221	Tim Miller
222	Wilson Yip
223	Karan Johar
224	Levent Semerci
225	Joss Whedon
226	Vincent Paronnaud
227	Jean-Marc Vallée
228	Gabriele Muccino
229	Edward Zwick
230	Paul Greengrass
231	Ki-duk Kim
232	Frank Miller
233	Julian Schnabel
234	Ömer Faruk Sorak
235	Brad Bird
236	Martin Campbell
237	Andrey Zvyagintsev
238	Alejandro Amenábar
239	Nikkhil Advani
240	Andrew Lau
241	Gore Verbinski
242	Tim Burton
243	Jae-young Kwak
244	Lars von Trier
245	Yilmaz Erdogan
246	Richard Kelly
247	Satoshi Kon
248	Walter Salles
249	Thomas Jahn
250	Billy Bob Thornton
251	Mike Leigh
252	Mamoru Oshii
253	Henry Selick
254	Harold Ramis
255	Taylor Hackford
256	Martin Brest
257	Ron Clements
258	Gary Trousdale
259	Kevin Costner
260	Spike Lee
261	Barry Levinson
262	Katsuhiro Ôtomo
263	Louis Malle
264	Richard Attenborough
265	Hal Ashby
266	Woody Allen
267	Mel Brooks
268	Franklin J. Schaffner
269	William Friedkin
270	Norman Jewison
271	Bernardo Bertolucci
272	Mike Nichols
273	Robert Wise
274	Jean-Luc Godard
275	Robert Rossen
276	Howard Hawks
277	Otto Preminger
278	Richard Brooks
279	Alexander Mackendrick
280	Charles Laughton
281	Nicholas Ray
282	Robert Hamer
283	Jacques Tourneur
284	W.S. Van Dyke
285	Lewis Milestone
286	Sergei M. Eisenstein
287	Rian Johnson
288	Mukesh Chhabra
289	Hirokazu Koreeda
290	Noah Baumbach
291	Luca Guadagnino
292	Ken Loach
293	Taika Waititi
294	Matt Ross
295	John Carney
296	Dan Gilroy
297	J.J. Abrams
298	Michel Hazanavicius
299	Doug Liman
300	Michael Haneke
301	Jacques Audiard
302	Duncan Jones
303	Tomas Alfredson
304	Neill Blomkamp
305	Imtiaz Ali
306	Cristian Mungiu
307	Richard Schenkman
308	Tarsem Singh
309	Ang Lee
310	Christophe Barratier
311	Jon Favreau
312	Edgar Wright
313	Fatih Akin
314	Alfonso Cuarón
315	Pedro Almodóvar
316	Danis Tanovic
317	Shin'ichirô Watanabe
318	Fabián Bielinsky
319	Cameron Crowe
320	Yoshifumi Kondô
321	Lee Tamahori
322	Tony Scott
323	Yoshiaki Kawajiri
324	Bob Clark
325	John Landis
326	Bob Fosse
327	George A. Romero
328	Alan J. Pakula
329	Alejandro Jodorowsky
330	Sam Peckinpah
331	Anthony Harvey
332	John Frankenheimer
333	Michelangelo Antonioni
334	Alain Resnais
335	Cecil B. DeMille
336	Fred Zinnemann
337	Henry Koster
338	George Seaton
339	George Cukor
340	Sam Wood
341	Merian C. Cooper
342	Tod Browning
343	Darius Marder
344	Paolo Genovese
345	Theodore Melfi
346	Paul King
347	Abhishek Chaubey
348	Travis Knight
349	Kenneth Lonergan
350	Martin Zandvliet
351	Gareth Edwards
352	Greta Gerwig
353	Dorota Kobiela
354	Matthew Warchus
355	Paolo Sorrentino
356	Ritesh Batra
357	Shoojit Sircar
358	Don Hall
359	Richard Curtis
360	Gauri Shinde
361	Josh Cooley
362	Adam McKay
363	Tetsuya Nakashima
364	Jee-woon Kim
365	Jeong-beom Lee
366	F. Gary Gray
367	Hong-jin Na
368	Niels Arden Oplev
369	Aaron Sorkin
370	David O. Russell
371	Pierre Morel
372	Mark Herman
373	Joe Wright
374	Nicolas Winding Refn
375	Jaco Van Dormael
376	Jonathan Dayton
377	Yash Chopra
378	Anders Thomas Jensen
379	Roger Donaldson
380	Mikael Håfström
381	Nick Cassavetes
382	Lukas Moodysson
383	Sylvain Chomet
384	Kevin Reynolds
385	Boaz Yakin
386	Troy Duffy
387	Joe Johnston
388	Andrew Adamson
389	Takeshi Kitano
390	Andrew Niccol
391	George P. Cosmatos
392	David Mickey Evans
393	James Ivory
394	Andrew Davis
395	Robert De Niro
396	Kevin Altieri
397	John Woo
398	Jim Jarmusch
399	John Singleton
400	Penny Marshall
401	Sam Raimi
402	John Hughes
403	Richard Donner
404	Roland Joffé
405	Ivan Reitman
406	Philip Kaufman
407	Robert Benton
408	Terrence Malick
409	René Laloux
410	Mel Stuart
411	John Schlesinger
412	Terence Young
413	Arthur Penn
414	Robert Stevenson
415	Ken Annakin
416	Jack Clayton
417	James Whale
418	Leo McCarey
419	Francis Lee
420	David Leitch
421	Taylor Sheridan
422	Jordan Peele
423	Christopher McQuarrie
424	Hannes Holm
425	Jemaine Clement
426	James Simone
427	James Marsh
428	Matthew Vaughn
429	Josh Boone
430	Alfonso Gomez-Rejon
431	Abdellatif Kechiche
432	Abhishek Kapoor
433	Felix van Groeningen
434	Alexander Payne
435	Rich Moore
436	Mark Osborne
437	Christopher Miller
438	Cary Joji Fukunaga
439	Ben Affleck
440	Marc Webb
441	Shûsuke Kaneko
442	Shane Meadows
443	Alex Garland
444	Susanne Bier
445	Kevin Macdonald
446	Paul McGuigan
447	Christian Carion
448	Anton Corbijn
449	Nathan Greno
450	Paul Verhoeven
451	Paul Haggis
452	Stephen Chow
453	Brad Anderson
454	Sofia Coppola
455	Mike Newell
456	Peter Mullan
457	Wolfgang Becker
458	Jessie Nelson
459	Stephen Daldry
460	John Cameron Mitchell
461	Steven Soderbergh
462	Bob Gale
463	Trey Parker
464	Mike Judge
465	Todd Solondz
466	Antoine Fuqua
467	James L. Brooks
468	Francis Veber
469	Scott Hicks
470	Gregory Hoblit
471	Kenneth Branagh
472	Michael Radford
473	Kevin Smith
474	Robert Altman
475	Brian Henson
476	James Foley
477	Jon Avnet
478	George Sluizer
479	Bruce Robinson
480	Jean-Jacques Annaud
481	Nicholas Meyer
482	Ted Kotcheff
483	Robert Redford
484	Jim Abrahams
485	Joseph Sargent
486	Robert Clouse
487	John Boorman
488	Don Siegel
489	Brian G. Hutton
490	Gene Saks
491	Cy Endfield
492	Guy Hamilton
493	J. Lee Thompson
494	Georges Franju
495	Charles Vidor
496	James Algar
497	Todd Haynes
498	Aneesh Chaganty
499	Sean Baker
500	Tyler Nilson
501	Sebastian Schipper
502	Deniz Gamze Ergüven
503	Joseph Kosinski
504	Ryan Coogler
505	David Mackenzie
506	Stephen Frears
507	Matt Reeves
508	David Ayer
509	Hiromasa Yonebayashi
510	Bradley Cooper
511	Pierre Coffin
512	Jonathan Levine
513	Daniel Monzón
514	Bennett Miller
515	Ruben Fleischer
516	Dennis Gansel
517	John Lee Hancock
518	David Cronenberg
519	Olivier Dahan
520	Ronny Yu
521	Neil Burger
522	Zack Snyder
523	James Wan
524	Charlie Kaufman
525	Gregg Araki
526	Yann Samuell
527	Marc Forster
528	Eric Bress
529	Kinji Fukasaku
530	Chris Columbus
531	Ted Demme
532	Mary Harron
533	Tom Tykwer
534	Tony Bancroft
535	Alex Proyas
536	Joel Schumacher
537	Jonathan Lynn
538	Marc Caro
539	David Zucker
540	Mark Rydell
541	Walter Hill
542	James Frawley
543	Martin Rosen
544	Wolfgang Reitherman
545	Richard Lester
546	Blake Edwards
547	George Stevens
\.


--
-- Data for Name: tbl_genders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_genders (id, name) FROM stdin;
1	Drama
2	Crime
3	Action
4	Adventure
5	Biography
6	Romance
7	Western
8	Sci-Fi
9	Comedy
10	Animation
11	War
12	Family
13	Music
14	Mystery
15	Horror
16	Thriller
17	Musical
18	Film-Noir
19	Fantasy
20	Sport
21	History
\.


--
-- Data for Name: tbl_historic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_historic (user_id, movie_id, minutes_watched, user_average, liked) FROM stdin;
1	3	152	10	t
1	155	140	10	t
2	65	60	5	f
2	72	100	6	f
\.


--
-- Data for Name: tbl_movie_actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_movie_actor (movie_id, actor_id) FROM stdin;
1	1
1	2
2	3
2	4
3	5
3	6
4	4
4	7
5	8
5	9
6	10
6	11
7	12
7	13
8	14
8	15
9	16
9	17
10	18
10	19
11	10
11	20
12	21
12	22
13	23
13	24
14	10
14	20
15	25
15	26
16	7
16	27
17	28
17	29
18	30
18	31
19	32
19	33
20	34
20	35
21	36
21	37
22	38
22	39
23	40
23	41
24	42
24	43
25	21
25	44
26	21
26	45
27	46
27	47
28	2
28	18
29	48
29	49
30	28
30	29
31	50
31	51
32	52
32	53
33	54
33	55
34	56
34	7
35	57
35	58
36	59
36	60
37	5
37	61
38	16
38	44
39	62
39	63
40	64
40	56
41	19
41	65
42	66
42	67
43	68
43	69
44	70
44	71
45	72
45	73
46	74
46	75
47	76
47	77
48	78
48	79
49	8
49	80
50	81
50	82
51	83
51	84
52	85
52	86
53	85
53	87
54	88
54	89
55	90
55	91
56	92
56	37
57	93
57	94
58	95
58	96
59	97
59	98
60	99
60	100
61	99
61	100
62	101
62	102
63	103
63	104
64	5
64	105
65	95
65	37
66	106
66	107
67	108
67	109
68	110
68	111
69	112
69	113
70	114
70	115
71	116
71	117
72	7
72	118
73	29
73	119
74	30
74	120
75	121
75	3
76	122
76	123
77	124
77	125
78	52
78	126
79	127
79	128
80	129
80	130
81	131
81	132
82	54
82	133
83	134
83	135
84	85
84	86
85	136
85	137
86	138
86	139
87	140
87	141
88	142
88	143
89	144
89	145
90	146
90	147
91	148
91	149
92	150
92	151
93	91
93	152
94	18
94	153
95	154
95	155
96	156
96	157
97	158
97	18
98	159
98	160
99	66
99	161
100	162
100	44
101	163
101	164
102	21
102	165
103	166
103	167
104	168
104	169
105	170
105	171
106	172
106	173
107	122
107	174
108	175
108	176
109	4
109	177
110	28
110	29
111	178
111	179
112	7
112	48
113	180
113	181
114	182
114	183
115	184
115	185
116	23
116	186
117	187
117	188
118	189
118	190
119	191
119	192
120	54
120	193
121	194
122	53
122	195
123	196
123	197
124	198
124	199
125	200
125	201
126	202
126	203
127	204
127	205
128	85
128	206
129	207
129	208
130	209
130	210
131	211
131	212
132	11
132	213
133	214
133	215
134	216
134	217
135	218
135	219
136	220
136	221
137	222
137	223
138	224
138	225
139	226
139	227
140	228
140	229
141	230
141	231
142	216
142	232
143	233
143	234
144	105
144	235
145	16
145	236
146	237
146	238
147	16
147	239
148	240
148	241
149	242
149	243
150	244
150	245
151	21
151	165
152	246
152	247
153	95
153	248
154	125
154	249
155	5
155	250
156	240
156	251
157	252
157	253
158	254
158	255
159	64
159	256
160	257
160	258
161	259
161	260
162	66
162	64
163	261
163	262
164	4
164	7
165	7
165	263
166	95
166	264
167	23
167	265
168	29
168	266
169	267
169	268
170	269
170	270
171	271
171	272
172	50
172	273
173	7
173	274
174	275
174	276
175	84
175	277
176	278
176	279
177	280
177	281
178	282
178	283
179	284
179	285
180	286
180	287
181	52
181	288
182	289
182	290
183	291
183	292
184	293
184	294
185	295
185	296
186	297
186	298
187	299
187	133
188	300
188	301
189	52
189	302
190	303
190	304
191	83
191	305
192	306
192	307
193	85
193	308
194	309
194	310
195	311
195	312
196	313
196	125
197	314
197	315
198	316
198	317
199	318
199	319
200	320
200	321
201	322
201	141
202	61
202	323
203	324
203	325
204	326
204	327
205	328
205	103
206	329
206	330
207	95
207	331
208	210
208	257
209	15
209	175
210	332
210	333
211	334
211	335
212	336
212	337
213	338
213	339
214	340
214	341
215	342
215	343
216	344
216	345
217	44
217	5
218	346
218	347
219	348
219	349
220	350
220	351
221	352
221	226
222	61
222	353
223	105
223	354
224	355
224	356
225	23
225	357
226	358
226	359
227	360
227	361
228	362
228	363
229	364
229	365
230	366
230	367
231	368
231	369
232	370
232	371
233	372
233	373
234	374
234	23
235	375
235	376
236	377
236	378
237	379
237	380
238	372
238	373
239	34
239	381
240	95
240	382
241	13
241	383
242	384
242	385
243	16
243	21
244	386
244	387
245	388
245	384
246	389
246	390
247	95
247	391
248	271
248	392
249	169
249	393
250	154
250	256
251	394
251	395
252	396
252	397
253	398
253	399
254	400
254	401
255	396
255	402
256	403
256	404
257	405
257	406
258	240
258	407
259	379
259	380
260	408
260	409
261	410
261	411
262	412
262	413
263	242
263	414
264	415
264	416
265	417
265	418
266	162
266	419
267	420
267	421
268	422
268	423
269	424
269	425
270	426
270	427
271	428
271	429
272	430
272	431
273	432
273	433
274	434
274	435
275	29
275	436
276	49
276	437
277	283
277	438
278	7
278	439
279	440
279	441
280	442
280	134
281	443
281	444
282	445
282	446
283	30
283	442
284	443
284	447
285	448
285	277
286	449
286	450
287	451
287	452
288	180
288	453
289	294
289	277
290	454
290	455
291	456
291	457
292	458
292	459
293	303
293	460
294	52
294	50
295	54
295	461
296	462
296	463
297	295
297	464
298	289
298	465
299	466
299	467
300	468
300	469
301	52
301	470
302	471
302	452
303	52
303	472
304	134
304	188
305	3
305	473
306	474
306	475
307	131
307	476
308	477
308	478
309	200
309	201
310	479
310	480
311	481
311	54
312	482
312	483
313	54
313	484
314	485
314	486
315	487
315	488
316	489
316	490
317	491
317	492
318	85
318	493
319	494
319	495
320	309
321	496
321	497
322	140
322	498
323	499
323	500
324	257
324	501
325	264
325	502
326	257
326	503
327	504
327	505
328	506
328	507
329	44
329	508
330	509
330	510
331	218
331	219
332	511
332	512
333	325
333	513
334	514
334	515
335	257
335	355
336	324
336	516
337	517
337	518
338	519
338	520
339	521
339	522
340	29
340	504
341	56
341	523
342	524
342	525
343	16
343	105
344	526
344	359
345	527
345	528
346	529
346	530
347	505
347	531
348	532
348	533
349	534
349	535
350	536
350	232
351	537
351	538
352	240
352	407
353	90
353	539
354	540
354	506
355	247
355	541
356	527
356	542
357	100
357	543
358	544
358	545
359	38
359	546
360	547
360	548
361	16
361	549
362	44
362	550
363	551
363	552
364	553
364	554
365	555
365	556
366	557
366	558
367	559
367	560
368	561
368	562
369	13
369	383
370	563
370	564
371	565
371	566
372	567
372	568
373	64
373	569
374	570
374	240
375	571
375	572
376	573
376	530
377	400
377	574
378	575
378	576
379	577
379	578
380	507
380	579
381	580
381	581
382	353
382	582
383	583
383	584
384	585
384	586
385	587
385	588
386	589
386	590
387	591
387	592
388	593
388	594
389	595
389	596
390	597
390	598
391	599
391	600
392	601
392	602
393	271
393	603
394	604
394	605
395	606
395	607
396	608
396	609
397	610
397	611
398	4
398	612
399	613
399	614
400	615
400	69
401	616
401	617
402	615
402	618
403	619
403	620
404	621
404	583
405	622
405	623
406	624
406	625
407	252
407	626
408	627
408	628
409	629
409	630
410	72
410	73
411	631
411	632
412	50
412	633
413	127
413	190
414	634
414	635
415	636
415	637
416	4
416	638
417	639
417	640
418	284
418	621
419	159
419	295
420	482
420	250
421	641
421	397
422	642
422	643
423	409
423	644
424	180
424	181
425	645
425	646
426	468
426	647
427	621
427	648
428	649
428	650
429	651
429	652
430	653
430	654
431	23
431	655
432	656
432	657
433	658
433	659
434	180
434	660
435	656
435	661
436	461
436	662
437	54
437	663
438	468
438	200
439	649
439	180
440	290
440	292
441	664
441	665
442	666
442	667
443	278
443	471
444	668
444	669
445	134
445	670
446	286
446	671
447	672
447	3
448	83
448	673
449	674
449	188
450	54
450	675
451	666
451	676
452	677
452	678
453	679
453	680
454	681
454	680
455	191
455	682
456	83
456	683
457	8
457	684
458	485
458	685
459	686
459	687
460	688
460	681
461	689
461	690
462	691
462	692
463	561
463	543
464	207
464	693
465	694
465	695
466	696
466	697
467	698
467	699
468	555
468	700
469	701
469	702
470	412
470	703
471	11
471	137
472	704
472	705
473	345
473	706
474	353
474	707
475	708
475	709
476	523
476	710
477	711
477	712
478	379
478	380
479	323
479	20
480	713
480	581
481	714
481	715
482	583
482	716
483	409
483	717
484	7
484	4
485	718
485	719
486	720
486	66
487	721
487	722
488	723
488	724
489	725
489	726
490	322
490	727
491	728
491	729
492	730
492	731
493	732
493	733
494	734
494	349
495	735
495	736
496	737
496	738
497	739
497	740
498	741
498	216
499	742
499	743
500	744
500	745
501	746
501	747
502	100
502	748
503	749
503	750
504	751
504	752
505	753
505	1
506	358
506	359
507	754
507	398
508	755
508	756
509	757
509	758
510	759
510	760
511	761
511	44
512	233
512	762
513	763
513	764
514	765
514	766
515	767
515	768
516	769
516	384
517	770
517	763
518	771
518	772
519	773
519	774
520	775
520	729
521	776
521	777
522	778
522	779
523	4
523	753
524	573
524	780
525	242
525	781
526	782
526	634
527	615
527	266
528	645
528	783
529	784
529	785
530	786
530	787
531	788
531	789
532	790
532	791
533	634
533	635
534	636
534	792
535	793
535	794
536	621
536	181
537	795
537	796
538	797
538	798
539	799
539	800
540	432
540	801
541	802
541	803
542	128
542	473
543	134
543	804
544	805
544	806
545	187
545	807
546	808
546	809
547	191
547	671
548	810
548	811
549	131
549	482
550	812
550	813
551	717
551	814
552	468
552	815
553	461
553	816
554	817
554	818
555	819
555	133
556	820
556	821
557	54
557	822
558	823
558	824
559	191
559	84
560	83
560	825
561	299
561	826
562	191
562	807
563	191
563	827
564	828
564	829
565	830
565	831
566	832
566	833
567	822
567	834
568	835
568	836
569	38
569	837
570	838
570	209
571	839
571	840
572	535
572	841
573	842
573	843
574	844
574	845
575	846
575	847
576	848
576	849
577	322
577	838
578	354
578	850
579	207
579	851
580	852
580	853
581	854
581	855
582	856
582	857
583	99
583	543
584	576
584	428
585	858
585	359
586	859
586	860
587	861
587	862
588	715
588	718
589	863
589	864
590	216
590	501
591	140
591	865
592	866
592	867
593	868
593	869
594	870
594	871
595	872
595	873
596	21
596	165
597	530
597	874
598	875
598	876
599	367
599	877
600	5
600	878
601	879
601	880
602	881
602	112
603	561
603	882
604	21
604	883
605	378
605	884
606	885
606	886
607	887
607	378
608	888
608	319
609	20
609	889
610	890
610	891
611	892
611	893
612	894
612	895
613	144
613	145
614	770
614	5
615	14
615	896
616	897
616	898
617	899
617	900
618	889
618	20
619	901
619	902
620	520
620	903
621	504
621	904
622	905
622	64
623	337
623	906
624	160
624	907
625	908
625	909
626	910
626	878
627	749
627	750
628	18
628	877
629	240
629	570
630	591
630	144
631	520
631	911
632	49
632	912
633	913
633	914
634	915
634	916
635	56
635	917
636	918
636	919
637	920
637	285
638	387
638	921
639	922
639	923
640	924
640	925
641	926
641	881
642	927
642	114
643	379
643	928
644	905
644	929
645	930
645	931
646	932
646	933
647	21
647	934
648	499
648	935
649	64
649	4
650	353
650	936
651	937
651	938
652	16
652	155
653	939
653	940
654	379
654	13
655	941
655	942
656	943
656	944
657	573
657	782
658	573
658	16
659	945
659	428
660	946
660	947
661	49
661	948
662	898
662	949
663	29
663	371
664	7
664	950
665	951
665	952
666	930
666	398
667	780
667	920
668	408
668	953
669	954
669	955
670	512
670	956
671	7
671	162
672	957
672	958
673	71
673	905
674	930
674	959
675	78
675	79
676	265
676	499
677	72
677	960
678	961
678	962
679	71
679	963
680	964
680	965
681	966
681	967
682	968
682	969
683	970
683	971
684	972
684	973
685	608
685	791
686	974
686	975
687	7
687	976
688	977
688	978
689	621
689	743
690	362
690	979
691	23
691	980
692	266
692	250
693	265
693	638
694	981
694	982
695	983
695	984
696	121
696	588
697	985
697	986
698	639
698	987
699	621
699	988
700	671
700	989
701	289
701	808
702	990
702	442
703	671
703	991
704	651
704	992
705	993
705	994
706	995
706	996
707	997
707	998
708	999
708	1000
709	1001
709	461
710	83
710	1002
711	83
711	825
712	1003
712	201
713	461
713	1004
714	1005
714	1006
715	807
715	191
716	1007
716	1008
717	831
717	1009
718	1010
718	1011
719	1012
719	1013
720	1014
720	1015
721	1016
721	1017
722	532
722	967
723	1018
723	710
724	1019
724	1020
725	583
725	1021
726	1022
726	1023
727	1024
727	1025
728	1026
728	1027
729	894
729	856
730	529
730	1028
731	1029
731	1030
732	1031
732	1032
733	347
733	1033
734	1034
734	1035
735	1036
735	207
736	1037
736	1038
737	99
737	543
738	340
738	1039
739	1040
739	1041
740	1042
740	1043
741	397
741	1044
742	62
742	1045
743	513
743	869
744	1046
744	521
745	1047
745	742
746	732
746	733
747	1048
747	1049
748	1050
748	336
749	903
749	1051
750	1033
750	1052
751	561
751	567
752	1052
752	1053
753	332
753	701
754	1054
754	17
755	358
755	359
756	877
756	44
757	1055
757	1056
758	1057
758	914
759	1058
759	1059
760	1060
760	1061
761	1062
761	1063
762	1064
762	1065
763	1066
763	1067
764	1068
764	868
765	144
765	1069
766	903
766	1070
767	353
767	100
768	1071
768	631
769	153
769	1072
770	1073
770	1074
771	1075
771	1076
772	1077
772	1078
773	353
773	6
774	64
774	5
775	375
775	1047
776	1079
776	1080
777	44
777	761
778	5
778	1081
779	103
779	1082
780	608
780	697
781	358
781	359
782	905
782	439
783	1083
783	1084
784	583
784	737
785	1085
785	1086
786	344
786	1087
787	1088
787	1074
788	753
788	177
789	1089
789	743
790	1071
790	400
791	21
791	1090
792	1091
792	1092
793	1093
793	1094
794	1095
794	1096
795	742
795	18
796	1097
796	1098
797	396
797	742
798	1099
798	69
799	1100
799	1101
800	1102
800	1103
801	1104
801	1105
802	905
802	379
803	221
803	608
804	1106
804	1107
805	1108
805	1109
806	30
806	934
807	271
807	1110
808	1111
808	1112
809	4
809	573
810	530
810	1113
811	362
811	1114
812	1115
812	654
813	1116
813	1117
814	1118
814	1119
815	1120
816	1121
816	1122
817	609
817	763
818	21
818	905
819	250
819	1123
820	905
820	1124
821	242
821	603
822	1125
822	1126
823	4
823	189
824	583
824	30
825	956
825	1127
826	396
826	1128
827	396
827	67
828	1129
828	79
829	1130
829	1131
830	1132
830	1133
831	1134
831	1135
832	5
832	1136
833	266
833	775
834	1137
834	1138
835	645
835	1139
836	1140
836	1141
837	634
837	645
838	180
838	1142
839	1143
839	1144
840	440
840	1145
841	1146
841	1147
842	1148
842	1149
843	1150
843	1151
844	1152
844	1153
845	1154
845	1155
846	634
846	635
847	1156
847	637
848	1157
848	639
849	4
849	1158
850	1159
850	1160
851	988
851	1161
852	265
852	636
853	23
853	1162
854	650
854	23
855	189
855	1156
856	1163
856	804
857	586
857	1164
858	1165
858	1166
859	586
859	1167
860	1168
860	469
861	266
861	1169
862	1170
862	1171
863	286
863	666
864	1172
864	1173
865	815
865	284
866	1174
866	1175
867	1176
867	1177
868	817
868	1178
869	188
869	127
870	83
870	671
871	461
871	824
872	1179
872	1180
873	83
873	807
874	1181
874	1182
875	1183
875	1184
876	1185
876	1186
877	346
877	39
878	1187
878	1188
879	16
879	18
880	1189
880	1190
881	1191
881	1192
882	1193
882	103
883	543
883	1194
884	1195
884	1196
885	1197
885	1198
886	1199
886	1200
887	521
887	906
888	1030
888	1201
889	967
889	57
890	21
890	1202
891	575
891	1203
892	613
892	1204
893	716
893	967
894	1193
894	440
895	1205
895	1206
896	732
896	1207
897	1208
897	1209
898	69
898	1210
899	1211
899	1212
900	517
900	1213
901	353
901	1214
902	339
902	1215
903	1216
903	1052
904	370
904	397
905	1217
905	1218
906	1219
906	878
907	17
907	1220
908	1221
908	1089
909	1222
909	1223
910	18
910	22
911	1224
911	1225
912	1050
912	505
913	1226
913	1198
914	100
914	1227
915	1228
915	1047
916	1229
916	1230
917	547
917	1231
918	767
918	11
919	1232
919	1233
920	1234
920	1235
921	905
921	764
922	2
922	256
923	1236
923	1237
924	754
924	1238
925	19
925	1239
926	1088
926	1240
927	358
927	359
928	1241
928	1242
929	697
929	1243
930	1244
930	1245
931	1089
931	379
932	624
932	1246
933	365
933	1074
934	1247
934	17
935	1248
935	1236
936	156
936	1249
937	1250
937	1251
938	753
938	1252
939	34
939	1253
940	573
940	155
941	19
941	1254
942	1255
942	1256
943	1257
943	1258
944	1064
944	1259
945	265
945	748
946	1260
946	387
947	358
947	1261
948	507
948	1262
949	573
949	1107
950	1227
950	256
951	583
951	734
952	905
952	1263
953	5
953	1264
954	761
954	1091
955	927
955	753
956	1265
956	1266
957	573
957	1252
958	1267
958	110
959	1268
959	1269
960	7
960	1270
961	1271
961	729
962	948
962	155
963	271
963	1272
964	573
964	1273
965	23
965	743
966	21
966	1274
967	777
967	380
968	941
968	1275
969	1276
969	1277
970	1278
970	726
971	1279
971	1280
972	1281
972	1282
973	1283
973	1278
974	4
974	635
975	1284
975	1285
976	613
976	1286
977	1287
977	1288
978	1289
978	1290
979	166
979	968
980	396
980	1291
981	807
981	8
982	166
982	1292
983	1293
983	1294
984	1295
984	1296
985	23
985	1297
986	1298
986	437
987	1299
987	1300
988	1301
988	1302
989	1303
989	1304
990	809
990	1305
991	23
991	1306
992	1307
992	1308
993	1309
993	1310
994	1311
994	1312
995	671
995	1313
996	649
996	1314
997	290
997	1315
998	1316
998	1317
999	1318
999	1319
\.


--
-- Data for Name: tbl_movie_director; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_movie_director (movie_id, director_id) FROM stdin;
1	1
2	2
3	3
4	2
5	4
6	5
7	6
8	7
9	3
10	8
11	5
12	9
13	10
14	5
15	11
16	12
17	13
18	14
19	15
20	16
21	17
22	3
23	18
24	19
25	7
26	1
27	20
28	8
29	21
30	22
31	23
32	24
33	25
34	26
35	27
36	28
37	3
38	12
39	29
40	30
41	31
42	32
43	33
44	34
45	35
46	36
47	37
48	9
49	10
50	38
51	39
52	40
53	40
54	41
55	42
56	43
57	44
58	45
59	46
60	47
61	47
62	48
63	6
64	3
65	49
66	50
67	51
68	52
69	53
70	3
71	19
72	10
73	7
74	54
75	2
76	30
77	55
78	24
79	54
80	56
81	54
82	38
83	56
84	40
85	57
86	58
87	59
88	60
89	61
90	62
91	63
92	64
93	65
94	6
95	66
96	67
97	68
98	69
99	57
100	70
101	71
102	72
103	73
104	6
105	54
106	74
107	35
108	14
109	75
110	76
111	77
112	12
113	78
114	54
115	54
116	10
117	79
118	56
119	38
120	38
121	80
122	24
123	81
124	56
125	82
126	83
127	83
128	40
129	45
130	84
131	85
132	86
133	87
134	88
135	89
136	90
137	91
138	92
139	93
140	94
141	95
142	96
143	97
144	98
145	12
146	99
147	12
148	100
149	101
150	102
151	48
152	103
153	93
154	104
155	3
156	105
157	106
158	19
159	107
160	108
161	68
162	109
163	110
164	111
165	12
166	112
167	113
168	7
169	114
170	19
171	115
172	24
173	12
174	116
175	117
176	118
177	119
178	120
179	121
180	122
181	24
182	123
183	56
184	117
185	117
186	124
187	38
188	125
189	24
190	126
191	127
192	128
193	40
194	129
195	130
196	131
197	132
198	133
199	53
200	134
201	135
202	136
203	137
204	138
205	99
206	139
207	49
208	140
209	141
210	8
211	142
212	73
213	99
214	143
215	144
216	107
217	136
218	145
219	146
220	147
221	148
222	63
223	149
224	150
225	113
226	151
227	152
228	153
229	154
230	155
231	156
232	157
233	49
234	113
235	158
236	159
237	160
238	49
239	16
240	161
241	6
242	51
243	7
244	162
245	99
246	163
247	105
248	164
249	36
250	165
251	114
252	166
253	167
254	168
255	166
256	114
257	169
258	170
259	160
260	171
261	167
262	7
263	172
264	173
265	174
266	165
267	175
268	176
269	177
270	19
271	178
272	179
273	180
274	117
275	30
276	181
277	182
278	183
279	184
280	4
281	54
282	116
283	29
284	185
285	117
286	116
287	186
288	187
289	117
290	116
291	188
292	189
293	190
294	24
295	191
296	116
297	117
298	123
299	192
300	193
301	24
302	194
303	24
304	79
305	195
306	196
307	56
308	197
309	198
310	199
311	128
312	38
313	25
314	200
315	201
316	25
317	202
318	40
319	203
320	204
321	205
322	206
323	207
324	208
325	209
326	150
327	27
328	210
329	30
330	211
331	89
332	37
333	212
334	148
335	150
336	213
337	214
338	215
339	216
340	63
341	217
342	32
343	162
344	212
345	218
346	219
347	220
348	221
349	62
350	94
351	222
352	223
353	224
354	168
355	69
356	218
357	225
358	226
359	227
360	228
361	229
362	230
363	231
364	232
365	233
366	234
367	235
368	236
369	6
370	237
371	231
372	238
373	107
374	239
375	240
376	241
377	242
378	235
379	243
380	244
381	245
382	246
383	101
384	244
385	181
386	247
387	61
388	248
389	235
390	249
391	250
392	251
393	120
394	252
395	253
396	254
397	255
398	256
399	257
400	176
401	258
402	259
403	260
404	261
405	262
406	175
407	177
408	263
409	19
410	35
411	264
412	24
413	265
414	266
415	7
416	4
417	267
418	268
419	269
420	126
421	185
422	270
423	271
424	78
425	29
426	268
427	272
428	272
429	273
430	79
431	10
432	194
433	274
434	275
435	194
436	276
437	277
438	82
439	278
440	279
441	54
442	280
443	194
444	196
445	56
446	193
447	195
448	281
449	282
450	38
451	283
452	79
453	277
454	193
455	25
456	127
457	191
458	200
459	201
460	284
461	285
462	286
463	287
464	288
465	289
466	290
467	291
468	292
469	141
470	293
471	294
472	295
473	293
474	296
475	293
476	63
477	297
478	160
479	32
480	139
481	298
482	299
483	300
484	12
485	301
486	302
487	303
488	304
489	69
490	305
491	160
492	306
493	297
494	87
495	307
496	113
497	308
498	309
499	141
500	227
501	310
502	311
503	312
504	313
505	113
506	314
507	174
508	315
509	316
510	317
511	299
512	318
513	314
514	319
515	181
516	72
517	101
518	320
519	321
520	322
521	171
522	323
523	75
524	242
525	172
526	266
527	75
528	266
529	120
530	175
531	324
532	325
533	266
534	326
535	327
536	328
537	329
538	194
539	189
540	180
541	265
542	268
543	330
544	327
545	331
546	270
547	80
548	332
549	54
550	333
551	334
552	335
553	191
554	195
555	336
556	38
557	337
558	338
559	38
560	276
561	56
562	339
563	276
564	39
565	340
566	341
567	342
568	203
569	68
570	88
571	343
572	62
573	3
574	344
575	345
576	346
577	347
578	348
579	150
580	349
581	350
582	351
583	47
584	6
585	352
586	353
587	354
588	62
589	355
590	356
591	357
592	358
593	359
594	360
595	19
596	361
597	36
598	141
599	155
600	362
601	363
602	364
603	8
604	230
605	365
606	366
607	16
608	367
609	5
610	300
611	368
612	369
613	61
614	370
615	371
616	372
617	295
618	5
619	313
620	373
621	374
622	30
623	35
624	375
625	73
626	376
627	312
628	8
629	377
630	378
631	373
632	379
633	247
634	225
635	136
636	380
637	381
638	248
639	382
640	383
641	53
642	384
643	160
644	385
645	309
646	315
647	9
648	386
649	111
650	387
651	388
652	35
653	389
654	390
655	8
656	244
657	242
658	153
659	391
660	392
661	393
662	251
663	394
664	395
665	396
666	397
667	398
668	171
669	399
670	175
671	400
672	19
673	229
674	397
675	9
676	179
677	115
678	401
679	402
680	398
681	403
682	7
683	402
684	404
685	405
686	406
687	12
688	7
689	407
690	408
691	113
692	127
693	2
694	409
695	336
696	408
697	326
698	410
699	411
700	412
701	123
702	413
703	339
704	414
705	415
706	192
707	416
708	274
709	276
710	127
711	276
712	38
713	191
714	38
715	276
716	417
717	418
718	276
719	417
720	314
721	419
722	420
723	421
724	422
725	423
726	424
727	425
728	426
729	427
730	428
731	429
732	430
733	162
734	431
735	432
736	433
737	47
738	305
739	434
740	435
741	436
742	31
743	266
744	437
745	314
746	297
747	438
748	8
749	428
750	26
751	57
752	370
753	439
754	440
755	151
756	19
757	107
758	247
759	113
760	175
761	142
762	441
763	442
764	443
765	444
766	445
767	8
768	446
769	447
770	448
771	449
772	450
773	309
774	136
775	451
776	452
777	230
778	453
779	255
780	454
781	455
782	322
783	253
784	229
785	456
786	457
787	172
788	458
789	217
790	30
791	57
792	106
793	459
794	460
795	461
796	323
797	166
798	462
799	463
800	464
801	465
802	466
803	141
804	238
805	217
806	467
807	33
808	468
809	455
810	469
811	470
812	471
813	314
814	167
815	472
816	473
817	474
818	21
819	475
820	260
821	111
822	19
823	476
824	175
825	477
826	166
827	166
828	9
829	478
830	479
831	271
832	7
833	480
834	181
835	266
836	12
837	266
838	4
839	481
840	482
841	483
842	484
843	19
844	178
845	29
846	266
847	485
848	267
849	4
850	486
851	487
852	269
853	488
854	489
855	490
856	190
857	189
858	336
859	29
860	491
861	492
862	38
863	493
864	199
865	121
866	494
867	488
868	281
869	279
870	56
871	191
872	273
873	127
874	495
875	496
876	417
877	497
878	498
879	6
880	237
881	499
882	213
883	440
884	500
885	501
886	502
887	216
888	312
889	503
890	7
891	235
892	257
893	63
894	504
895	237
896	505
897	506
898	507
899	133
900	214
901	508
902	509
903	510
904	157
905	444
906	511
907	512
908	428
909	513
910	514
911	315
912	515
913	516
914	68
915	517
916	145
917	228
918	518
919	428
920	146
921	260
922	439
923	519
924	520
925	521
926	442
927	151
928	522
929	266
930	522
931	390
932	523
933	524
934	525
935	526
936	67
937	145
938	162
939	53
940	527
941	260
942	528
943	168
944	529
945	141
946	314
947	530
948	238
949	531
950	480
951	7
952	270
953	532
954	533
955	408
956	534
957	120
958	300
959	535
960	261
961	181
962	309
963	115
964	398
965	113
966	107
967	171
968	536
969	160
970	537
971	37
972	538
973	530
974	2
975	175
976	257
977	539
978	402
979	403
980	166
981	540
982	149
983	541
984	542
985	488
986	543
987	179
988	7
989	474
990	10
991	489
992	544
993	333
994	545
995	546
996	547
997	336
998	38
999	38
\.


--
-- Data for Name: tbl_movie_gender; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_movie_gender (movie_id, gender_id) FROM stdin;
1	1
2	2
2	1
3	3
3	2
4	2
4	1
5	2
5	1
6	3
6	4
7	2
7	1
8	5
8	1
9	3
9	4
10	1
11	3
11	4
12	1
12	6
13	7
14	3
14	4
15	3
15	8
16	5
16	2
17	3
17	4
18	1
19	5
19	1
20	9
20	1
21	1
22	4
22	1
23	2
23	1
24	10
24	4
25	1
25	11
26	2
26	1
27	9
27	1
28	2
28	1
29	2
29	1
30	3
30	4
31	3
31	1
32	3
32	4
33	1
33	12
34	2
34	1
35	1
35	13
36	5
36	9
37	1
37	14
38	2
38	1
39	5
39	1
40	3
40	4
41	1
42	2
42	14
43	3
43	2
44	10
44	4
45	3
45	8
46	1
46	6
47	10
47	1
48	4
48	9
49	7
50	15
50	14
51	1
51	6
52	9
52	1
53	9
53	1
54	1
55	5
55	1
56	3
56	2
57	10
57	1
58	3
58	5
59	10
59	3
60	3
60	4
61	3
61	4
62	10
62	4
63	1
63	7
64	3
64	4
65	9
65	1
66	1
66	12
67	10
67	4
68	1
68	14
69	3
69	1
70	14
70	16
71	10
71	3
72	2
72	1
73	3
73	4
74	1
74	15
75	1
75	14
76	15
76	8
77	1
77	17
78	2
78	1
79	9
80	2
80	1
81	1
81	11
82	14
82	16
83	1
83	18
84	9
84	1
85	1
85	16
86	1
86	19
87	2
87	1
88	2
88	1
89	1
90	1
91	1
91	14
92	1
93	1
93	12
94	4
94	1
95	1
95	6
96	9
96	6
97	9
97	2
98	1
99	1
100	1
100	6
101	1
101	12
102	10
102	4
103	5
103	1
104	2
104	1
105	1
105	11
106	1
106	16
107	3
107	4
108	5
108	1
109	2
109	1
110	3
110	4
111	4
111	1
112	2
112	1
113	9
113	2
114	2
114	1
115	4
115	8
116	7
117	4
117	5
118	9
118	1
119	4
119	14
120	14
120	6
121	9
121	17
122	1
123	1
124	2
124	1
125	1
125	14
126	2
126	14
127	1
127	8
128	9
128	1
129	9
129	1
130	3
130	1
131	3
131	1
132	5
132	9
133	9
133	2
134	2
134	1
135	3
135	1
136	10
136	4
137	4
137	9
138	1
138	11
139	5
139	1
140	3
140	9
141	1
142	3
142	5
143	1
143	14
144	3
144	1
145	14
145	16
146	10
146	4
147	5
147	2
148	1
148	12
149	1
150	1
150	19
151	10
151	4
152	3
152	1
153	9
153	2
154	1
155	3
155	4
156	1
157	5
157	1
158	10
158	4
159	5
159	1
160	3
160	9
161	3
161	9
162	2
162	1
163	2
163	1
164	2
164	1
165	2
165	1
166	3
166	9
167	1
167	7
168	3
168	4
169	9
169	2
170	10
170	12
171	3
171	16
172	3
172	1
173	5
173	1
174	1
174	8
175	1
175	13
176	5
176	1
177	3
177	4
178	4
178	9
179	4
179	1
180	2
180	1
181	3
181	1
182	1
182	11
183	9
183	13
184	1
184	6
185	1
185	19
186	2
186	1
187	2
187	16
188	1
189	2
189	1
190	1
191	4
191	1
192	9
192	11
193	4
193	9
194	3
194	9
195	1
195	6
196	1
196	16
197	10
197	1
198	2
198	1
199	1
199	6
200	1
201	3
201	2
202	3
202	1
203	1
203	16
204	9
204	1
205	10
205	4
206	1
207	9
207	1
208	9
208	1
209	4
209	9
210	1
210	14
211	10
211	1
212	5
212	1
213	10
213	4
214	9
214	1
215	5
215	1
216	3
216	5
217	3
217	5
218	5
218	2
219	10
219	4
220	14
220	16
221	9
221	1
222	2
222	1
223	3
223	4
224	3
224	2
225	1
226	4
226	1
227	1
227	13
228	5
228	1
229	10
229	9
230	10
230	3
231	4
231	5
232	2
232	1
233	9
233	1
234	1
234	20
235	5
235	1
236	3
236	1
237	1
237	6
238	9
238	1
239	2
239	1
240	9
240	1
241	3
241	2
242	10
242	4
243	5
243	2
244	1
244	16
245	10
245	4
246	10
246	3
247	4
247	1
248	1
248	14
249	1
249	13
250	9
250	1
251	9
251	2
252	9
252	2
253	1
253	6
254	1
255	2
255	1
256	9
256	1
257	2
257	1
258	1
258	6
259	1
259	6
260	1
260	14
261	9
261	2
262	3
262	4
263	5
263	2
264	1
264	13
265	1
265	21
266	9
266	1
267	4
267	1
268	1
268	11
269	1
270	10
270	4
271	15
271	14
272	1
272	19
273	4
273	1
274	1
275	3
275	8
276	5
276	1
277	9
278	1
278	11
279	1
279	20
280	1
281	4
281	1
282	5
282	1
283	1
283	14
284	9
284	2
285	1
286	1
286	14
287	2
287	1
288	2
288	1
289	1
289	16
290	5
290	1
291	1
291	11
292	1
292	19
293	1
293	15
294	3
294	9
295	1
295	7
296	1
296	11
297	1
298	5
298	1
299	2
299	1
300	4
300	1
301	4
301	1
302	1
303	1
303	21
304	4
304	1
305	2
305	1
306	4
306	1
307	1
307	18
308	3
308	2
309	18
309	14
310	1
310	13
311	9
311	1
312	1
312	14
313	9
313	1
314	1
314	21
315	1
315	11
316	9
316	6
317	5
317	1
318	9
318	6
319	1
319	6
320	3
320	4
321	19
321	15
322	9
322	1
323	4
323	5
324	1
324	21
325	3
325	4
326	3
326	2
327	9
327	1
328	5
328	1
329	4
329	1
330	10
330	4
331	3
331	1
332	10
332	4
333	1
333	12
334	1
334	13
335	2
335	1
336	1
337	3
337	2
338	5
338	1
339	3
339	4
340	3
340	1
341	1
341	6
342	5
342	1
343	3
343	4
344	1
344	6
345	3
345	2
346	5
346	1
347	1
348	3
348	4
349	1
349	14
350	1
350	6
351	3
351	5
352	1
353	3
353	1
354	1
354	6
355	1
355	16
356	3
356	2
357	3
357	4
358	10
358	5
359	5
359	1
360	5
360	1
361	4
361	1
362	3
362	14
363	2
363	1
364	2
364	16
365	5
365	1
366	4
366	9
367	10
367	4
368	3
368	4
369	3
369	2
370	1
371	1
371	6
372	5
372	1
373	5
373	1
374	9
374	1
375	3
375	2
376	3
376	4
377	4
377	1
378	10
378	3
379	9
379	1
380	2
380	1
381	9
381	1
382	1
382	14
383	1
384	2
384	1
385	5
385	1
386	10
386	2
387	1
388	1
389	10
389	3
390	3
390	2
391	1
392	9
392	1
393	14
393	8
394	10
394	3
395	10
395	12
396	9
396	19
397	2
397	1
398	1
399	10
399	4
400	1
400	21
401	10
401	12
402	4
402	1
403	9
403	1
404	1
405	10
405	3
406	4
406	12
407	1
407	19
408	1
408	11
409	10
409	4
410	3
410	8
411	5
411	1
412	1
412	21
413	9
413	1
414	9
414	6
415	4
415	16
416	5
416	2
417	9
418	5
418	2
419	15
420	14
420	16
421	1
421	6
422	1
422	12
423	1
424	5
424	2
425	1
425	15
426	4
426	8
427	9
427	1
428	1
429	5
429	1
430	1
430	6
431	3
431	1
432	1
433	1
434	1
434	20
435	9
435	1
436	3
436	1
437	2
437	1
438	2
438	1
439	1
440	1
440	18
441	2
441	1
442	2
442	1
443	1
444	2
444	1
445	9
445	1
446	9
446	6
447	1
448	1
448	18
449	9
449	2
450	2
450	1
451	2
451	1
452	1
452	6
453	1
453	18
454	1
454	6
455	9
455	2
456	18
456	14
457	1
457	21
458	4
458	12
459	9
459	1
460	9
460	2
461	1
461	11
462	1
462	21
463	9
463	2
464	9
464	1
465	2
465	1
466	9
466	1
467	1
467	6
468	1
469	10
469	4
470	4
470	9
471	9
471	1
472	9
472	1
473	3
473	4
474	2
474	1
475	9
475	1
476	1
476	8
477	3
477	4
478	1
478	6
479	3
479	4
480	2
480	1
481	9
481	1
482	3
482	4
483	1
483	6
484	5
484	2
485	2
485	1
486	1
486	14
487	2
487	1
488	3
488	8
489	1
489	20
490	9
490	1
491	1
492	1
493	3
493	4
494	9
494	2
495	1
495	19
496	3
496	4
497	4
497	1
498	4
498	1
499	10
499	4
500	9
500	1
501	1
501	13
502	3
502	4
503	9
503	15
504	1
504	6
505	2
505	1
506	4
506	12
507	3
507	4
508	1
508	14
509	9
509	1
510	10
510	3
511	3
511	14
512	2
512	1
513	4
513	1
514	4
514	9
515	1
515	14
516	10
516	4
517	1
518	10
518	1
519	2
519	1
520	2
520	1
521	1
521	13
522	10
522	3
523	2
523	1
524	1
524	19
525	5
525	1
526	9
526	1
527	2
527	1
528	9
528	1
529	1
529	8
530	9
530	13
531	9
531	12
532	3
532	4
533	9
533	1
534	1
534	13
535	3
535	4
536	5
536	1
537	4
537	1
538	9
538	1
539	9
540	3
540	4
541	9
541	1
542	5
542	1
543	3
543	4
544	15
544	16
545	5
545	1
546	2
546	1
547	9
547	14
548	1
548	16
549	4
549	5
550	1
550	14
551	1
551	6
552	4
552	1
553	4
553	1
554	1
555	1
555	16
556	2
556	18
557	9
557	1
558	9
558	1
559	1
559	18
560	2
560	18
561	1
561	18
562	9
562	6
563	9
563	1
564	3
564	4
565	9
565	13
566	4
566	15
567	1
567	15
568	19
568	15
569	3
569	9
570	3
570	1
571	1
571	13
572	1
573	3
573	1
574	9
574	1
575	5
575	1
576	4
576	9
577	3
577	2
578	10
578	3
579	5
579	1
580	1
581	1
581	21
582	3
582	4
583	3
583	4
584	2
584	1
585	1
585	6
586	10
586	5
587	5
587	9
588	1
588	14
589	1
590	1
590	6
591	9
591	6
592	10
592	3
593	9
593	1
594	9
594	1
595	10
595	5
596	10
596	4
597	2
597	1
598	9
598	1
599	10
599	3
600	5
600	9
601	1
601	16
602	3
602	2
603	2
603	1
604	4
604	5
605	3
605	2
606	5
606	1
607	2
607	1
608	3
608	2
609	4
609	19
610	1
610	21
611	2
611	1
612	1
612	21
613	9
613	1
614	5
614	1
615	3
615	16
616	1
616	21
617	1
617	13
618	4
618	19
619	1
620	1
620	14
621	2
621	1
622	5
622	2
623	3
623	4
624	1
624	19
625	3
625	4
626	9
626	1
627	3
627	9
628	1
628	19
629	1
629	12
630	9
630	2
631	1
631	6
632	5
632	1
633	10
633	4
634	3
634	4
635	5
635	1
636	1
637	1
637	6
638	4
638	5
639	2
639	1
640	10
640	9
641	3
641	1
642	3
642	4
643	10
643	1
644	5
644	1
645	3
645	4
646	1
647	4
647	1
648	3
648	2
649	5
649	1
650	5
650	1
651	10
651	4
652	1
652	6
653	2
653	1
654	1
654	8
655	3
655	1
656	1
657	5
657	9
658	1
659	3
659	5
660	9
660	1
661	1
661	6
662	9
662	1
663	3
663	2
664	2
664	1
665	10
665	3
666	3
666	2
667	9
667	1
668	1
668	19
669	2
669	1
670	1
670	16
671	5
671	1
672	10
672	4
673	5
673	1
674	3
674	2
675	4
675	9
676	2
676	1
677	3
677	4
678	3
678	9
679	9
680	9
680	2
681	4
681	9
682	1
683	9
683	1
684	5
684	1
685	3
685	9
686	4
686	5
687	9
687	2
688	12
688	8
689	1
690	1
690	6
691	7
692	4
692	21
693	1
693	14
694	10
694	8
695	2
695	1
696	3
696	2
697	1
697	13
698	12
698	19
699	1
700	16
701	9
701	1
702	3
702	5
703	1
703	12
704	9
704	12
705	3
705	1
706	1
706	6
707	15
708	2
708	1
709	3
709	4
710	3
710	2
711	4
711	9
712	18
712	16
713	4
713	1
714	14
714	16
715	9
715	12
716	1
716	15
717	9
717	17
718	3
718	2
719	1
719	15
720	1
721	1
721	6
722	3
722	4
723	2
723	1
724	15
724	14
725	3
725	4
726	9
726	1
727	9
727	15
728	10
728	1
729	5
729	1
730	3
730	4
731	1
731	6
732	9
732	1
733	9
733	1
734	1
734	6
735	1
735	20
736	1
736	13
737	3
737	4
738	1
738	13
739	4
739	9
740	10
740	4
741	10
741	4
742	1
743	9
743	19
744	10
744	3
745	1
745	8
746	3
746	4
747	1
747	11
748	5
748	1
749	3
749	4
750	9
751	3
751	4
752	9
752	1
753	5
753	1
754	9
754	1
755	4
755	12
756	10
756	4
757	5
757	1
758	10
758	1
759	5
759	2
760	9
760	1
761	10
761	4
762	2
762	1
763	2
763	1
764	1
764	8
765	1
766	5
766	1
767	2
767	1
768	3
768	2
769	1
769	21
770	5
770	1
771	10
771	4
772	1
772	16
773	1
773	6
774	3
774	2
775	2
775	1
776	3
776	9
777	3
777	14
778	1
778	16
779	5
779	1
780	9
780	1
781	4
781	12
782	3
782	2
783	10
783	1
784	3
784	1
785	1
786	9
786	1
787	1
788	1
789	9
789	1
790	1
790	21
791	2
791	1
792	1
792	16
793	1
793	13
794	9
794	1
795	2
795	16
796	10
796	3
797	4
797	9
798	4
798	9
799	10
799	9
800	9
801	9
801	1
802	2
802	1
803	9
803	1
804	1
804	14
805	9
805	1
806	9
806	1
807	3
807	4
808	9
809	5
809	2
810	5
810	1
811	2
811	1
812	1
813	1
813	12
814	9
814	2
815	5
815	9
816	9
817	9
817	1
818	1
819	9
819	1
820	5
820	1
821	3
821	4
822	10
822	4
823	2
823	1
824	1
824	16
825	1
826	9
826	1
827	2
827	1
828	10
828	4
829	14
829	16
830	9
830	1
831	5
831	1
832	3
832	1
833	2
833	1
834	1
834	14
835	9
835	19
836	9
836	2
837	9
838	1
839	3
839	4
840	3
840	4
841	1
842	9
843	10
843	4
844	15
844	16
845	1
845	16
846	9
846	11
847	3
847	2
848	9
848	7
849	5
849	2
850	3
850	2
851	4
851	1
852	3
852	2
853	3
853	2
854	3
854	4
855	9
856	3
856	4
857	1
857	6
858	5
858	1
859	1
859	15
860	1
860	21
861	3
861	4
862	1
862	15
863	1
863	16
864	1
864	15
865	3
865	4
866	1
866	15
867	1
867	15
868	1
869	9
869	2
870	9
870	1
871	9
871	1
872	1
872	8
873	4
873	1
874	1
874	18
875	10
875	12
876	15
876	8
877	5
877	1
878	1
878	14
879	9
879	1
880	1
881	1
882	5
882	2
883	1
884	4
884	9
885	2
885	1
886	1
887	3
887	4
888	3
888	2
889	3
889	5
890	1
890	21
891	10
891	3
892	10
892	4
893	3
893	2
894	1
894	20
895	2
895	1
896	3
896	2
897	5
897	9
898	3
898	4
899	14
899	16
900	3
900	16
901	3
901	2
902	10
902	4
903	1
903	13
904	1
904	7
905	1
905	6
906	10
906	9
907	9
907	1
908	3
908	9
909	3
909	4
910	5
910	1
911	1
911	15
912	4
912	9
913	1
913	16
914	3
914	4
915	5
915	1
916	1
917	1
918	3
918	2
919	4
919	12
920	10
920	4
921	2
921	1
922	2
922	1
923	5
923	1
924	3
924	5
925	1
925	19
926	2
926	1
927	3
927	4
928	3
928	1
929	1
929	6
930	3
930	1
931	3
931	2
932	15
932	14
933	1
934	1
935	9
935	1
936	1
936	14
937	9
937	1
938	2
938	1
939	2
939	1
940	5
940	1
941	1
942	1
942	8
943	1
943	15
944	3
944	4
945	9
945	1
946	1
947	4
947	12
948	15
948	14
949	5
949	2
950	1
950	21
951	3
951	2
952	5
952	1
953	9
953	2
954	2
954	1
955	1
955	11
956	10
956	4
957	4
957	9
958	2
958	1
959	14
959	8
960	2
960	1
961	14
961	16
962	1
962	6
963	3
963	4
964	4
964	1
965	1
965	6
966	4
966	1
967	9
967	1
968	3
968	2
969	9
970	9
970	2
971	10
971	1
972	9
972	2
973	9
973	12
974	2
974	1
975	9
975	1
976	10
976	12
977	9
977	2
978	9
978	1
979	3
979	2
980	2
980	1
981	1
982	3
982	4
983	3
983	2
984	4
984	9
985	3
985	5
986	10
986	4
987	5
987	2
988	1
988	8
989	9
989	2
990	1
990	11
991	4
991	9
992	10
992	4
993	1
993	14
994	9
994	13
995	9
995	1
996	1
996	7
997	1
997	6
998	1
998	11
999	2
999	14
\.


--
-- Data for Name: tbl_movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_movies (id, title, description, duration, released_year, average, rating_id) FROM stdin;
1	The Shawshank Redemption	Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.	142	1994	9.3	1
2	The Godfather	An organized crime dynasty's aging patriarch transfers control of his clandestine empire to his reluctant son.	175	1972	9.2	1
3	The Dark Knight	When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.	152	2008	9	2
4	The Godfather: Part II	The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.	202	1974	9	1
5	12 Angry Men	A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.	96	1957	9	3
6	The Lord of the Rings: The Return of the King	Gandalf and Aragorn lead the World of Men against Sauron's army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.	201	2003	8.9	3
7	Pulp Fiction	The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.	154	1994	8.9	1
8	Schindler's List	In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.	195	1993	8.9	1
9	Inception	A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.	148	2010	8.8	2
10	Fight Club	An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.	139	1999	8.8	1
11	The Lord of the Rings: The Fellowship of the Ring	A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.	178	2001	8.8	3
12	Forrest Gump	The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate and other historical events unfold through the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.	142	1994	8.8	2
13	Il buono, il brutto, il cattivo	A bounty hunting scam joins two men in an uneasy alliance against a third in a race to find a fortune in gold buried in a remote cemetery.	161	1966	8.8	1
14	The Lord of the Rings: The Two Towers	While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron's new ally, Saruman, and his hordes of Isengard.	179	2002	8.7	2
15	The Matrix	When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking truth--the life he knows is the elaborate deception of an evil cyber-intelligence.	136	1999	8.7	1
16	Goodfellas	The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.	146	1990	8.7	1
17	Star Wars: Episode V - The Empire Strikes Back	After the Rebels are brutally overpowered by the Empire on the ice planet Hoth, Luke Skywalker begins Jedi training with Yoda, while his friends are pursued by Darth Vader and a bounty hunter named Boba Fett all over the galaxy.	124	1980	8.7	2
18	One Flew Over the Cuckoo's Nest	A criminal pleads insanity and is admitted to a mental institution, where he rebels against the oppressive nurse and rallies up the scared patients.	133	1975	8.7	1
19	Hamilton	The real life of one of America's foremost founding fathers and first Secretary of the Treasury, Alexander Hamilton. Captured live on Broadway from the Richard Rodgers Theater with the original Broadway cast.	160	2020	8.6	4
20	Gisaengchung	Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.	132	2019	8.6	1
21	Soorarai Pottru	Nedumaaran Rajangam "Maara" sets out to make the common man fly and in the process takes on the world's most capital intensive industry and several enemies who stand in his way.	153	2020	8.6	3
22	Interstellar	A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.	169	2014	8.6	2
23	Cidade de Deus	In the slums of Rio, two kids' paths diverge as one struggles to become a photographer and the other a kingpin.	130	2002	8.6	1
24	Sen to Chihiro no kamikakushi	During her family's move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.	125	2001	8.6	3
25	Saving Private Ryan	Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action.	169	1998	8.6	5
26	The Green Mile	The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift.	189	1999	8.6	1
27	La vita è bella	When an open-minded Jewish librarian and his son become victims of the Holocaust, he uses a perfect mixture of will, humor, and imagination to protect his son from the dangers around their camp.	116	1997	8.6	3
28	Se7en	Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his motives.	127	1995	8.6	1
29	The Silence of the Lambs	A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.	118	1991	8.6	1
30	Star Wars	Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire's world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth Vader.	121	1977	8.6	2
31	Seppuku	When a ronin requesting seppuku at a feudal lord's palace is told of the brutal suicide of another ronin who previously visited, he reveals how their pasts are intertwined - and in doing so challenges the clan's integrity.	133	1962	8.6	6
32	Shichinin no samurai	A poor village under attack by bandits recruits seven unemployed samurai to help them defend themselves.	207	1954	8.6	3
33	It's a Wonderful Life	An angel is sent from Heaven to help a desperately frustrated businessman by showing him what life would have been like if he had never existed.	130	1946	8.6	7
34	Joker	In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society. He then embarks on a downward spiral of revolution and bloody crime. This path brings him face-to-face with his alter-ego: the Joker.	122	2019	8.5	1
35	Whiplash	A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor who will stop at nothing to realize a student's potential.	106	2014	8.5	1
36	The Intouchables	After he becomes a quadriplegic from a paragliding accident, an aristocrat hires a young man from the projects to be his caregiver.	112	2011	8.5	2
37	The Prestige	After a tragic accident, two stage magicians engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.	130	2006	8.5	3
38	The Departed	An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.	151	2006	8.5	1
39	The Pianist	A Polish Jewish musician struggles to survive the destruction of the Warsaw ghetto of World War II.	150	2002	8.5	5
40	Gladiator	A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.	155	2000	8.5	2
41	American History X	A former neo-nazi skinhead tries to prevent his younger brother from going down the same wrong path that he did.	119	1998	8.5	5
42	The Usual Suspects	A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat, which began when five criminals met at a seemingly random police lineup.	106	1995	8.5	1
43	Léon	Mathilda, a 12-year-old girl, is reluctantly taken in by Léon, a professional assassin, after her family is murdered. An unusual relationship forms as she becomes his protégée and learns the assassin's trade.	110	1994	8.5	1
44	The Lion King	Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself.	88	1994	8.5	3
45	Terminator 2: Judgment Day	A cyborg, identical to the one who failed to kill Sarah Connor, must now protect her teenage son, John Connor, from a more advanced and powerful cyborg.	137	1991	8.5	3
46	Nuovo Cinema Paradiso	A filmmaker recalls his childhood when falling in love with the pictures at the cinema of his home village and forms a deep friendship with the cinema's projectionist.	155	1988	8.5	3
47	Hotaru no haka	A young boy and his little sister struggle to survive in Japan during World War II.	89	1988	8.5	3
48	Back to the Future	Marty McFly, a 17-year-old high school student, is accidentally sent thirty years into the past in a time-traveling DeLorean invented by his close friend, the eccentric scientist Doc Brown.	116	1985	8.5	3
49	Once Upon a Time in the West	A mysterious stranger with a harmonica joins forces with a notorious desperado to protect a beautiful widow from a ruthless assassin working for the railroad.	165	1968	8.5	3
50	Psycho	A Phoenix secretary embezzles $40,000 from her employer's client, goes on the run, and checks into a remote motel run by a young man under the domination of his mother.	109	1960	8.5	1
51	Casablanca	A cynical expatriate American cafe owner struggles to decide whether or not to help his former lover and her fugitive husband escape the Nazis in French Morocco.	102	1942	8.5	3
52	Modern Times	The Tramp struggles to live in modern industrial society with the help of a young homeless woman.	87	1936	8.5	8
53	City Lights	With the aid of a wealthy erratic tippler, a dewy-eyed tramp who has fallen in love with a sightless flower girl accumulates money to be able to help her medically.	87	1931	8.5	8
54	Capharnaüm	While serving a five-year sentence for a violent crime, a 12-year-old boy sues his parents for neglect.	126	2018	8.4	1
55	Ayla: The Daughter of War	In 1950, amid-st the ravages of the Korean War, Sergeant Süleyman stumbles upon a half-frozen little girl, with no parents and no help in sight. Frantic, scared and on the verge of death, ...                See full summary »	125	2017	8.4	6
56	Vikram Vedha	Vikram, a no-nonsense police officer, accompanied by Simon, his partner, is on the hunt to capture Vedha, a smuggler and a murderer. Vedha tries to change Vikram's life, which leads to a conflict.	147	2017	8.4	2
57	Kimi no na wa.	Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?	106	2016	8.4	3
58	Dangal	Former wrestler Mahavir Singh Phogat and his two wrestler daughters struggle towards glory at the Commonwealth Games in the face of societal oppression.	161	2016	8.4	3
59	Spider-Man: Into the Spider-Verse	Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.	117	2018	8.4	3
60	Avengers: Endgame	After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.	181	2019	8.4	2
61	Avengers: Infinity War	The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.	149	2018	8.4	2
62	Coco	Aspiring musician Miguel, confronted with his family's ancestral ban on music, enters the Land of the Dead to find his great-great-grandfather, a legendary singer.	105	2017	8.4	3
63	Django Unchained	With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.	165	2012	8.4	1
64	The Dark Knight Rises	Eight years after the Joker's reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.	164	2012	8.4	2
65	3 Idiots	Two friends are searching for their long lost companion. They revisit their college days and recall the memories of their friend who inspired them to think differently, even as the rest of the world called them "idiots".	170	2009	8.4	2
66	Taare Zameen Par	An eight-year-old boy is thought to be a lazy trouble-maker, until the new art teacher has the patience and compassion to discover the real problem behind his struggles in school.	165	2007	8.4	3
67	WALL·E	In the distant future, a small waste-collecting robot inadvertently embarks on a space journey that will ultimately decide the fate of mankind.	98	2008	8.4	3
68	The Lives of Others	In 1984 East Berlin, an agent of the secret police, conducting surveillance on a writer and his lover, finds himself becoming increasingly absorbed by their lives.	137	2006	8.4	1
69	Oldeuboi	After being kidnapped and imprisoned for fifteen years, Oh Dae-Su is released, only to find that he must find his captor in five days.	101	2003	8.4	1
70	Memento	A man with short-term memory loss attempts to track down his wife's murderer.	113	2000	8.4	2
71	Mononoke-hime	On a journey to find the cure for a Tatarigami's curse, Ashitaka finds himself in the middle of a war between the forest gods and Tatara, a mining colony. In this quest he also meets San, the Mononoke Hime.	134	1997	8.4	3
72	Once Upon a Time in America	A former Prohibition-era Jewish gangster returns to the Lower East Side of Manhattan over thirty years later, where he once again must confront the ghosts and regrets of his old life.	229	1984	8.4	1
73	Raiders of the Lost Ark	In 1936, archaeologist and adventurer Indiana Jones is hired by the U.S. government to find the Ark of the Covenant before Adolf Hitler's Nazis can obtain its awesome powers.	115	1981	8.4	1
74	The Shining	A family heads to an isolated hotel for the winter where a sinister presence influences the father into violence, while his psychic son sees horrific forebodings from both past and future.	146	1980	8.4	1
75	Apocalypse Now	A U.S. Army officer serving in Vietnam is tasked with assassinating a renegade Special Forces Colonel who sees himself as a god.	147	1979	8.4	5
76	Alien	After a space merchant vessel receives an unknown transmission as a distress call, one of the crew is attacked by a mysterious life form and they soon realize that its life cycle has merely begun.	117	1979	8.4	5
77	Anand	The story of a terminally ill man who wishes to live life to the fullest before the inevitable occurs, as told by his best friend.	122	1971	8.4	3
78	Tengoku to jigoku	An executive of a shoe company becomes a victim of extortion when his chauffeur's son is kidnapped and held for ransom.	143	1963	8.4	6
79	Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb	An insane general triggers a path to nuclear holocaust that a War Room full of politicians and generals frantically tries to stop.	95	1964	8.4	1
80	Witness for the Prosecution	A veteran British barrister must defend his client in a murder trial that has surprise after surprise.	116	1957	8.4	3
81	Paths of Glory	After refusing to attack an enemy position, a general accuses the soldiers of cowardice and their commanding officer must defend them.	88	1957	8.4	1
82	Rear Window	A wheelchair-bound photographer spies on his neighbors from his apartment window and becomes convinced one of them has committed murder.	112	1954	8.4	3
83	Sunset Blvd.	A screenwriter develops a dangerous relationship with a faded film star determined to make a triumphant return.	110	1950	8.4	9
84	The Great Dictator	Dictator Adenoid Hynkel tries to expand his empire while a poor Jewish barber tries to avoid persecution from Hynkel's regime.	125	1940	8.4	9
85	1917	April 6th, 1917. As a regiment assembles to wage war deep in enemy territory, two soldiers are assigned to race against time and deliver a message that will stop 1,600 men from walking straight into a deadly trap.	119	2019	8.3	5
86	Tumbbad	A mythological story about a goddess who created the entire universe. The plot revolves around the consequences when humans build a temple for her first-born.	104	2018	8.3	1
87	Andhadhun	A series of mysterious events change the life of a blind pianist, who must now report a crime that he should technically know nothing of.	139	2018	8.3	2
88	Drishyam	A man goes to extreme lengths to save his family from punishment after the family commits an accidental crime.	160	2013	8.3	3
89	Jagten	A teacher lives a lonely life, all the while struggling over his son's custody. His life slowly gets better as he finds love and receives good news from his son, but his new luck is about to be brutally shattered by an innocent little lie.	115	2012	8.3	5
90	Jodaeiye Nader az Simin	A married couple are faced with a difficult decision - to improve the life of their child by moving to another country or to stay in Iran and look after a deteriorating parent who has Alzheimer's disease.	123	2011	8.3	4
91	Incendies	Twins journey to the Middle East to discover their family history and fulfill their mother's last wishes.	131	2010	8.3	5
92	Miracle in cell NO.7	A story of love between a mentally-ill father who was wrongly accused of murder and his lovely six years old daughter. The prison would be their home. Based on the 2013 Korean movie 7-beon-bang-ui seon-mul (2013).	132	2019	8.3	10
93	Babam ve Oglum	The family of a left-wing journalist is torn apart after the military coup of Turkey in 1980.	112	2005	8.3	6
94	Inglourious Basterds	In Nazi-occupied France during World War II, a plan to assassinate Nazi leaders by a group of Jewish U.S. soldiers coincides with a theatre owner's vengeful plans for the same.	153	2009	8.3	1
95	Eternal Sunshine of the Spotless Mind	When their relationship turns sour, a couple undergoes a medical procedure to have each other erased from their memories.	108	2004	8.3	2
96	Amélie	Amélie is an innocent and naive girl in Paris with her own sense of justice. She decides to help those around her and, along the way, discovers love.	122	2001	8.3	3
97	Snatch	Unscrupulous boxing promoters, violent bookmakers, a Russian gangster, incompetent amateur robbers and supposedly Jewish jewelers fight to track down a priceless stolen diamond.	104	2000	8.3	2
98	Requiem for a Dream	The drug-induced utopias of four Coney Island people are shattered when their addictions run deep.	102	2000	8.3	1
99	American Beauty	A sexually frustrated suburban father has a mid-life crisis after becoming infatuated with his daughter's best friend.	122	1999	8.3	2
100	Good Will Hunting	Will Hunting, a janitor at M.I.T., has a gift for mathematics, but needs help from a psychologist to find direction in his life.	126	1997	8.3	3
101	Bacheha-Ye aseman	After a boy loses his sister's pair of shoes, he goes on a series of adventures in order to find them. When he can't, he tries a new way to "win" a new pair.	89	1997	8.3	7
102	Toy Story	A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy's room.	81	1995	8.3	3
103	Braveheart	Scottish warrior William Wallace leads his countrymen in a rebellion to free his homeland from the tyranny of King Edward I of England.	178	1995	8.3	1
104	Reservoir Dogs	When a simple jewelry heist goes horribly wrong, the surviving criminals begin to suspect that one of them is a police informant.	99	1992	8.3	5
105	Full Metal Jacket	A pragmatic U.S. Marine observes the dehumanizing effects the Vietnam War has on his fellow recruits from their brutal boot camp training to the bloody street fighting in Hue.	116	1987	8.3	2
106	Idi i smotri	After finding an old rifle, a young boy joins the Soviet resistance movement against ruthless German forces and experiences the horrors of World War II.	142	1985	8.3	1
107	Aliens	Fifty-seven years after surviving an apocalyptic attack aboard her space vessel by merciless space creatures, Officer Ripley awakens from hyper-sleep and tries to warn anyone who will listen about the predators.	137	1986	8.3	3
108	Amadeus	The life, success and troubles of Wolfgang Amadeus Mozart, as told by Antonio Salieri, the contemporaneous composer who was insanely jealous of Mozart's talent and claimed to have murdered him.	160	1984	8.3	5
109	Scarface	In 1980 Miami, a determined Cuban immigrant takes over a drug cartel and succumbs to greed.	170	1983	8.3	1
110	Star Wars: Episode VI - Return of the Jedi	After a daring mission to rescue Han Solo from Jabba the Hutt, the Rebels dispatch to Endor to destroy the second Death Star. Meanwhile, Luke struggles to help Darth Vader back from the dark side without falling into the Emperor's trap.	131	1983	8.3	3
111	Das Boot	The claustrophobic world of a WWII German U-boat; boredom, filth and sheer terror.	149	1981	8.3	5
112	Taxi Driver	A mentally unstable veteran works as a nighttime taxi driver in New York City, where the perceived decadence and sleaze fuels his urge for violent action by attempting to liberate a presidential campaign worker and an underage prostitute.	114	1976	8.3	1
113	The Sting	Two grifters team up to pull off the ultimate con.	129	1973	8.3	3
114	A Clockwork Orange	In the future, a sadistic gang leader is imprisoned and volunteers for a conduct-aversion experiment, but it doesn't go as planned.	136	1971	8.3	1
115	2001: A Space Odyssey	After discovering a mysterious artifact buried beneath the Lunar surface, mankind sets off on a quest to find its origins with help from intelligent supercomputer H.A.L. 9000.	149	1968	8.3	3
116	Per qualche dollaro in più	Two bounty hunters with the same intentions team up to track down a Western outlaw.	132	1965	8.3	3
117	Lawrence of Arabia	The story of T.E. Lawrence, the English officer who successfully united and led the diverse, often warring, Arab tribes during World War I in order to fight the Turks.	228	1962	8.3	3
118	The Apartment	A man tries to rise in his company by letting its executives use his apartment for trysts, but complications and a romance of his own ensue.	125	1960	8.3	3
119	North by Northwest	A New York City advertising executive goes on the run after being mistaken for a government agent by a group of foreign spies.	136	1959	8.3	3
120	Vertigo	A former police detective juggles wrestling with his personal demons and becoming obsessed with a hauntingly beautiful woman.	128	1958	8.3	1
121	Singin' in the Rain	A silent film production company and cast make a difficult transition to sound.	103	1952	8.3	8
122	Ikiru	A bureaucrat tries to find a meaning in his life after he discovers he has terminal cancer.	143	1952	8.3	6
123	Ladri di biciclette	In post-war Italy, a working-class man's bicycle is stolen. He and his son set out to find it.	89	1948	8.3	6
124	Double Indemnity	An insurance representative lets himself be talked by a seductive housewife into a murder/insurance fraud scheme that arouses the suspicion of an insurance investigator.	107	1944	8.3	9
125	Citizen Kane	Following the death of publishing tycoon Charles Foster Kane, reporters scramble to uncover the meaning of his final utterance; 'Rosebud'.	119	1941	8.3	2
126	M - Eine Stadt sucht einen Mörder	When the police in a German city are unable to catch a child-murderer, other criminals join in the manhunt.	117	1931	8.3	9
127	Metropolis	In a futuristic city sharply divided between the working class and the city planners, the son of the city's mastermind falls in love with a working-class prophet who predicts the coming of a savior to mediate their differences.	153	1927	8.3	6
128	The Kid	The Tramp cares for an abandoned child, but events put that relationship in jeopardy.	68	1921	8.3	9
129	Chhichhore	A tragic incident forces Anirudh, a middle-aged man, to take a trip down memory lane and reminisce his college days along with his friends, who were labelled as losers.	143	2019	8.2	2
130	Uri: The Surgical Strike	Indian army special forces execute a covert operation, avenging the killing of fellow army men at their base by a terrorist group.	138	2018	8.2	2
131	K.G.F: Chapter 1	In the 1970s, a fierce rebel rises against brutal oppression and becomes the symbol of hope to legions of downtrodden people.	156	2018	8.2	2
132	Green Book	A working-class Italian-American bouncer becomes the driver of an African-American classical pianist on a tour of venues through the 1960s American South.	130	2018	8.2	2
133	Three Billboards Outside Ebbing, Missouri	A mother personally challenges the local authorities to solve her daughter's murder when they fail to catch the culprit.	115	2017	8.2	1
134	Talvar	An experienced investigator confronts several conflicting theories about the perpetrators of a violent double homicide.	132	2015	8.2	2
135	Baahubali 2: The Conclusion	When Shiva, the son of Bahubali, learns about his heritage, he begins to look for answers. His story is juxtaposed with past events that unfolded in the Mahishmati Kingdom.	167	2017	8.2	2
136	Klaus	A simple act of kindness always sparks another, even in a frozen, faraway place. When Smeerensburg's new postman, Jesper, befriends toymaker Klaus, their gifts melt an age-old feud and deliver a sleigh full of holiday traditions.	96	2019	8.2	7
137	Queen	A Delhi girl from a traditional family sets out on a solo honeymoon after her marriage gets cancelled.	146	2013	8.2	2
138	Mandariinid	In 1992, war rages in Abkhazia, a breakaway region of Georgia. An Estonian man Ivo has decided to stay behind and harvest his crops of tangerines. In a bloody conflict at his door, a wounded man is left behind, and Ivo takes him in.	87	2013	8.2	6
139	Bhaag Milkha Bhaag	The truth behind the ascension of Milkha Singh who was scarred because of the India-Pakistan partition.	186	2013	8.2	3
140	Gangs of Wasseypur	A clash between Sultan and Shahid Khan leads to the expulsion of Khan from Wasseypur, and ignites a deadly blood feud spanning three generations.	321	2012	8.2	1
141	Udaan	Expelled from his school, a 16-year old boy returns home to his abusive and oppressive father.	134	2010	8.2	2
142	Paan Singh Tomar	The story of Paan Singh Tomar, an Indian athlete and seven-time national steeplechase champion who becomes one of the most feared dacoits in Chambal Valley after his retirement.	135	2012	8.2	2
143	El secreto de sus ojos	A retired legal counselor writes a novel hoping to find closure for one of his past unresolved homicide cases and for his unreciprocated love with his superior - both of which still haunt him decades later.	129	2009	8.2	5
144	Warrior	The youngest son of an alcoholic former boxer returns home, where he's trained by his father for competition in a mixed martial arts tournament - a path that puts the fighter on a collision course with his estranged, older brother.	140	2011	8.2	2
145	Shutter Island	In 1954, a U.S. Marshal investigates the disappearance of a murderer who escaped from a hospital for the criminally insane.	138	2010	8.2	1
146	Up	78-year-old Carl Fredricksen travels to Paradise Falls in his house equipped with balloons, inadvertently taking a young stowaway.	96	2009	8.2	3
147	The Wolf of Wall Street	Based on the true story of Jordan Belfort, from his rise to a wealthy stock-broker living the high life to his fall involving crime, corruption and the federal government.	180	2013	8.2	1
148	Chak De! India	Kabir Khan is the coach of the Indian Women's National Hockey Team and his dream is to make his all girls team emerge victorious against all odds.	153	2007	8.2	3
149	There Will Be Blood	A story of family, religion, hatred, oil and madness, focusing on a turn-of-the-century prospector in the early days of the business.	158	2007	8.2	1
150	Pan's Labyrinth	In the Falangist Spain of 1944, the bookish young stepdaughter of a sadistic army officer escapes into an eerie but captivating fantasy world.	118	2006	8.2	2
151	Toy Story 3	The toys are mistakenly delivered to a day-care center instead of the attic right before Andy leaves for college, and it's up to Woody to convince the other toys that they weren't abandoned and to return home.	103	2010	8.2	3
152	V for Vendetta	In a future British tyranny, a shadowy freedom fighter, known only by the alias of "V", plots to overthrow it with the help of a young woman.	132	2005	8.2	1
153	Rang De Basanti	The story of six young Indians who assist an English woman to film a documentary on the freedom fighters from their past, and the events that lead them to relive the long-forgotten saga of freedom.	167	2006	8.2	2
154	Black	The cathartic tale of a young woman who can't see, hear or talk and the teacher who brings a ray of light into her dark world.	122	2005	8.2	3
155	Batman Begins	After training with his mentor, Batman begins his fight to free crime-ridden Gotham City from corruption.	140	2005	8.2	2
156	Swades: We, the People	A successful Indian scientist returns to an Indian village to take his nanny to America with him and in the process rediscovers his roots.	210	2004	8.2	3
157	Der Untergang	Traudl Junge, the final secretary for Adolf Hitler, tells of the Nazi dictator's final days in his Berlin bunker at the end of WWII.	156	2004	8.2	5
158	Hauru no ugoku shiro	When an unconfident young woman is cursed with an old body by a spiteful witch, her only chance of breaking the spell lies with a self-indulgent yet insecure young wizard and his companions in his legged, walking castle.	119	2004	8.2	3
159	A Beautiful Mind	After John Nash, a brilliant but asocial mathematician, accepts secret work in cryptography, his life takes a turn for the nightmarish.	135	2001	8.2	2
160	Hera Pheri	Three unemployed men look for answers to all their money problems - but when their opportunity arrives, will they know what to do with it?	156	2000	8.2	3
161	Lock, Stock and Two Smoking Barrels	A botched card game in London triggers four friends, thugs, weed-growers, hard gangsters, loan sharks and debt collectors to collide with each other in a series of unexpected events, all for the sake of weed, cash and two antique shotguns.	107	1998	8.2	1
162	L.A. Confidential	As corruption grows in 1950s Los Angeles, three policemen - one strait-laced, one brutal, and one sleazy - investigate a series of murders with their own brand of justice.	138	1997	8.2	1
163	Eskiya	Baran the Bandit, released from prison after 35 years, searches for vengeance and his lover.	128	1996	8.2	6
164	Heat	A group of professional bank robbers start to feel the heat from police when they unknowingly leave a clue at their latest heist.	170	1995	8.2	1
165	Casino	A tale of greed, deception, money, power, and murder occur between two best friends: a mafia enforcer and a casino executive compete against each other over a gambling empire, and over a fast-living and fast-loving socialite.	178	1995	8.2	1
166	Andaz Apna Apna	Two slackers competing for the affections of an heiress inadvertently become her protectors from an evil criminal.	160	1994	8.2	3
167	Unforgiven	Retired Old West gunslinger William Munny reluctantly takes on one last job, with the help of his old partner Ned Logan and a young man, The "Schofield Kid."	130	1992	8.2	1
168	Indiana Jones and the Last Crusade	In 1938, after his father Professor Henry Jones, Sr. goes missing while pursuing the Holy Grail, Professor Henry "Indiana" Jones, Jr. finds himself up against Adolf Hitler's Nazis again to stop them from obtaining its powers.	127	1989	8.2	3
169	Dom za vesanje	In this luminous tale set in the area around Sarajevo and in Italy, Perhan, an engaging young Romany (gypsy) with telekinetic powers, is seduced by the quick-cash world of petty crime, which threatens to destroy him and those he loves.	142	1988	8.2	5
170	Tonari no Totoro	When two girls move to the country to be near their ailing mother, they have adventures with the wondrous forest spirits who live nearby.	86	1988	8.2	3
171	Die Hard	An NYPD officer tries to save his wife and several others taken hostage by German terrorists during a Christmas party at the Nakatomi Plaza in Los Angeles.	132	1988	8.2	1
172	Ran	In Medieval Japan, an elderly warlord retires, handing over his empire to his three sons. However, he vastly underestimates how the new-found power will corrupt them and cause them to turn on each other...and him.	162	1985	8.2	3
173	Raging Bull	The life of boxer Jake LaMotta, whose violence and temper that led him to the top in the ring destroyed his life outside of it.	129	1980	8.2	1
174	Stalker	A guide leads two men through an area known as the Zone to find a room that grants wishes.	162	1979	8.2	3
175	Höstsonaten	A married daughter who longs for her mother's love is visited by the latter, a successful concert pianist.	99	1978	8.2	3
176	The Message	This epic historical drama chronicles the life and times of Prophet Muhammad and serves as an introduction to early Islamic history.	177	1976	8.2	7
177	Sholay	After his family is murdered by a notorious and ruthless bandit, a former police officer enlists the services of two outlaws to capture the bandit.	204	1975	8.2	3
178	Monty Python and the Holy Grail	King Arthur and his Knights of the Round Table embark on a surreal, low-budget search for the Holy Grail, encountering many, very silly obstacles.	91	1975	8.2	7
179	The Great Escape	Allied prisoners of war plan for several hundred of their number to escape from a German camp during World War II.	172	1963	8.2	3
180	To Kill a Mockingbird	Atticus Finch, a lawyer in the Depression-era South, defends a black man against an undeserved rape charge, and his children against prejudice.	129	1962	8.2	3
181	Yôjinbô	A crafty ronin comes to a town divided by two criminal gangs and decides to play them against each other to free the town.	110	1961	8.2	6
182	Judgment at Nuremberg	In 1948, an American court in occupied Germany tries four Nazis judged for war crimes.	179	1961	8.2	1
183	Some Like It Hot	After two male musicians witness a mob hit, they flee the state in an all-female band disguised as women, but further complications set in.	121	1959	8.2	3
184	Smultronstället	After living a life marked by coldness, an aging professor is forced to confront the emptiness of his existence.	91	1957	8.2	3
185	Det sjunde inseglet	A man seeks answers about life, death, and the existence of God as he plays chess against the Grim Reaper during the Black Plague.	96	1957	8.2	1
186	Du rififi chez les hommes	Four men plan a technically perfect crime, but the human element intervenes...	118	1955	8.2	6
187	Dial M for Murder	A former tennis player tries to arrange his wife's murder after learning of her affair.	105	1954	8.2	1
188	Tôkyô monogatari	An old couple visit their children and grandchildren in the city, but receive little attention.	136	1953	8.2	3
189	Rashômon	The rape of a bride and the murder of her samurai husband are recalled from the perspectives of a bandit, the bride, the samurai's ghost and a woodcutter.	88	1950	8.2	6
190	All About Eve	A seemingly timid but secretly ruthless ingénue insinuates herself into the lives of an aging Broadway star and her circle of theater friends.	138	1950	8.2	9
191	The Treasure of the Sierra Madre	Two Americans searching for work in Mexico convince an old prospector to help them mine for gold in the Sierra Madre Mountains.	126	1948	8.2	9
192	To Be or Not to Be	During the Nazi occupation of Poland, an acting troupe becomes embroiled in a Polish soldier's efforts to track down a German spy.	99	1942	8.2	9
193	The Gold Rush	A prospector goes to the Klondike in search of gold and finds it and more.	95	1925	8.2	9
194	Sherlock Jr.	A film projectionist longs to be a detective, and puts his meagre skills to work when he is framed by a rival for stealing his girlfriend's father's pocketwatch.	45	1924	8.2	9
195	Portrait de la jeune fille en feu	On an isolated island in Brittany at the end of the eighteenth century, a female painter is obliged to paint a wedding portrait of a young woman.	122	2019	8.1	5
196	Pink	When three young women are implicated in a crime, a retired lawyer steps forward to help them clear their names.	136	2016	8.1	2
197	Koe no katachi	A young man is ostracized by his classmates after he bullies a deaf girl to the point where she moves away. Years later, he sets off on a path for redemption.	130	2016	8.1	11
198	Contratiempo	A successful entrepreneur accused of murder and a witness preparation expert have less than three hours to come up with an impregnable defense.	106	2016	8.1	12
199	Ah-ga-ssi	A woman is hired as a handmaiden to a Japanese heiress, but secretly she is involved in a plot to defraud her.	145	2016	8.1	1
200	Mommy	A widowed single mother, raising her violent son alone, finds new hope when a mysterious neighbor inserts herself into their household.	139	2014	8.1	5
201	Haider	A young man returns to Kashmir after his father's disappearance to confront his uncle, whom he suspects of playing a role in his father's fate.	160	2014	8.1	2
202	Logan	In a future where mutants are nearly extinct, an elderly and weary Logan leads a quiet life. But when Laura, a mutant child pursued by scientists, comes to him for help, he must get her to safety.	137	2017	8.1	1
203	Room	Held captive for 7 years in an enclosed space, a woman and her young son finally gain their freedom, allowing the boy to experience the outside world for the first time.	118	2015	8.1	5
204	Relatos salvajes	Six short stories that explore the extremities of human behavior involving people in distress.	122	2014	8.1	5
205	Soul	After landing the gig of a lifetime, a New York jazz pianist suddenly finds himself trapped in a strange land between Earth and the afterlife.	100	2020	8.1	3
206	Kis Uykusu	A hotel owner and landlord in a remote Turkish village deals with conflicts within his family and a tenant behind on his rent.	196	2014	8.1	6
207	PK	An alien on Earth loses the only device he can use to communicate with his spaceship. His innocent nature and child-like questions force the country to evaluate the impact of religion on its people.	153	2014	8.1	2
208	OMG: Oh My God!	A shopkeeper takes God to court when his shop is destroyed by an earthquake.	125	2012	8.1	3
209	The Grand Budapest Hotel	A writer encounters the owner of an aging high-class hotel, who tells him of his early years serving as a lobby boy in the hotel's glorious years under an exceptional concierge.	99	2014	8.1	2
210	Gone Girl	With his wife's disappearance having become the focus of an intense media circus, a man sees the spotlight turned on him when it's suspected that he may not be innocent.	149	2014	8.1	1
211	Ôkami kodomo no Ame to Yuki	After her werewolf lover unexpectedly dies in an accident while hunting for food for their children, a young woman must find ways to raise the werewolf son and daughter that she had with him while keeping their trait hidden from society.	117	2012	8.1	3
212	Hacksaw Ridge	World War II American Army Medic Desmond T. Doss, who served during the Battle of Okinawa, refuses to kill people, and becomes the first man in American history to receive the Medal of Honor without firing a shot.	139	2016	8.1	1
213	Inside Out	After young Riley is uprooted from her Midwest life and moved to San Francisco, her emotions - Joy, Fear, Anger, Disgust and Sadness - conflict on how best to navigate a new city, house, and school.	95	2015	8.1	3
214	Barfi!	Three young people learn that love can neither be defined nor contained by society's definition of normal and abnormal.	151	2012	8.1	3
215	12 Years a Slave	In the antebellum United States, Solomon Northup, a free black man from upstate New York, is abducted and sold into slavery.	134	2013	8.1	1
216	Rush	The merciless 1970s rivalry between Formula One rivals James Hunt and Niki Lauda.	123	2013	8.1	2
217	Ford v Ferrari	American car designer Carroll Shelby and driver Ken Miles battle corporate interference and the laws of physics to build a revolutionary race car for Ford in order to defeat Ferrari at the 24 Hours of Le Mans in 1966.	152	2019	8.1	2
218	Spotlight	The true story of how the Boston Globe uncovered the massive scandal of child molestation and cover-up within the local Catholic Archdiocese, shaking the entire Catholic Church to its core.	129	2015	8.1	1
219	Song of the Sea	Ben, a young Irish boy, and his little sister Saoirse, a girl who can turn into a seal, go on an adventure to free the fairies and save the spirit world.	93	2014	8.1	7
220	Kahaani	A pregnant woman's search for her missing husband takes her from London to Kolkata, but everyone she questions denies having ever met him.	122	2012	8.1	2
221	Zindagi Na Milegi Dobara	Three friends decide to turn their fantasy vacation into reality after one of their friends gets engaged.	155	2011	8.1	3
222	Prisoners	When Keller Dover's daughter and her friend go missing, he takes matters into his own hands as the police pursue multiple leads and the pressure mounts.	153	2013	8.1	1
223	Mad Max: Fury Road	In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max.	120	2015	8.1	2
224	A Wednesday	A retiring police officer reminisces about the most astounding day of his career. About a case that was never filed but continues to haunt him in his memories - the case of a man and a Wednesday.	104	2008	8.1	2
225	Gran Torino	Disgruntled Korean War veteran Walt Kowalski sets out to reform his neighbor, Thao Lor, a Hmong teenager who tried to steal Kowalski's prized possession: a 1972 Gran Torino.	116	2008	8.1	5
226	Harry Potter and the Deathly Hallows: Part 2	Harry, Ron, and Hermione search for Voldemort's remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts.	130	2011	8.1	2
227	Okuribito	A newly unemployed cellist takes a job preparing the dead for funerals.	130	2008	8.1	4
228	Hachi: A Dog's Tale	A college professor bonds with an abandoned dog he takes into his home.	93	2009	8.1	8
229	Mary and Max	A tale of friendship between two unlikely pen pals: Mary, a lonely, eight-year-old girl living in the suburbs of Melbourne, and Max, a forty-four-year old, severely obese man living in New York.	92	2009	8.1	6
230	How to Train Your Dragon	A hapless young Viking who aspires to hunt dragons becomes the unlikely friend of a young dragon himself, and learns there may be more to the creatures than he assumed.	98	2010	8.1	3
231	Into the Wild	After graduating from Emory University, top student and athlete Christopher McCandless abandons his possessions, gives his entire $24,000 savings account to charity and hitchhikes to Alaska to live in the wilderness. Along the way, Christopher encounters a series of characters that shape his life.	148	2007	8.1	5
232	No Country for Old Men	Violence and mayhem ensue after a hunter stumbles upon a drug deal gone wrong and more than two million dollars in cash near the Rio Grande.	122	2007	8.1	5
233	Lage Raho Munna Bhai	Munna Bhai embarks on a journey with Mahatma Gandhi in order to fight against a corrupt property dealer.	144	2006	8.1	3
234	Million Dollar Baby	A determined woman works with a hardened boxing trainer to become a professional.	132	2004	8.1	2
235	Hotel Rwanda	Paul Rusesabagina, a hotel manager, houses over a thousand Tutsi refugees during their struggle against the Hutu militia in Rwanda, Africa.	121	2004	8.1	4
236	Taegukgi hwinalrimyeo	When two brothers are forced to fight in the Korean War, the elder decides to take the riskiest missions if it will help shield the younger from battle.	140	2004	8.1	5
237	Before Sunset	Nine years after Jesse and Celine first met, they encounter each other again on the French leg of Jesse's book tour.	80	2004	8.1	5
238	Munna Bhai M.B.B.S.	A gangster sets out to fulfill his father's dream of becoming a doctor.	156	2003	8.1	3
239	Salinui chueok	In a small Korean province in 1986, two detectives struggle with the case of multiple young women being found raped and murdered by an unknown culprit.	131	2003	8.1	2
240	Dil Chahta Hai	Three inseparable childhood friends are just out of college. Nothing comes between them - until they each fall in love, and their wildly different approaches to relationships creates tension.	183	2001	8.1	13
241	Kill Bill: Vol. 1	After awakening from a four-year coma, a former assassin wreaks vengeance on the team of assassins who betrayed her.	111	2003	8.1	5
242	Finding Nemo	After his son is captured in the Great Barrier Reef and taken to Sydney, a timid clownfish sets out on a journey to bring him home.	100	2003	8.1	3
243	Catch Me If You Can	Barely 21 yet, Frank is a skilled forger who has passed as a doctor, lawyer and pilot. FBI agent Carl becomes obsessed with tracking down the con man, who only revels in the pursuit.	141	2002	8.1	1
244	Amores perros	A horrific car accident connects three stories, each involving characters dealing with loss, regret, and life's harsh realities, all in the name of love.	154	2000	8.1	1
245	Monsters, Inc.	In order to power the city, monsters have to scare children so that they scream. However, the children are toxic to the monsters, and after a child gets through, 2 monsters realize things may not be what they think.	92	2001	8.1	3
246	Shin seiki Evangelion Gekijô-ban: Air/Magokoro wo, kimi ni	Concurrent theatrical ending of the TV series Shin seiki evangerion (1995).	87	1997	8.1	2
247	Lagaan: Once Upon a Time in India	The people of a small village in Victorian India stake their future on a game of cricket against their ruthless British rulers.	224	2001	8.1	3
248	The Sixth Sense	A boy who communicates with spirits seeks the help of a disheartened child psychologist.	107	1999	8.1	1
249	La leggenda del pianista sull'oceano	A baby boy, discovered in 1900 on an ocean liner, grows into a musical prodigy, never setting foot on land.	169	1998	8.1	3
250	The Truman Show	An insurance salesman discovers his whole life is actually a reality TV show.	103	1998	8.1	3
251	Crna macka, beli macor	Matko and his son Zare live on the banks of the Danube river and get by through hustling and basically doing anything to make a living. In order to pay off a business debt Matko agrees to marry off Zare to the sister of a local gangster.	127	1998	8.1	5
252	The Big Lebowski	Jeff "The Dude" Lebowski, mistaken for a millionaire of the same name, seeks restitution for his ruined rug and enlists his bowling buddies to help get it.	117	1998	8.1	5
253	Fa yeung nin wah	Two neighbors, a woman and a man, form a strong bond after both suspect extramarital activities of their spouses. However, they agree to keep their bond platonic so as not to commit similar wrongs.	98	2000	8.1	3
254	Trainspotting	Renton, deeply immersed in the Edinburgh drug scene, tries to clean up and get out, despite the allure of the drugs and influence of friends.	93	1996	8.1	1
255	Fargo	Jerry Lundegaard's inept crime falls apart due to his and his henchmen's bungling and the persistent police work of the quite pregnant Marge Gunderson.	98	1996	8.1	1
256	Underground	A group of Serbian socialists prepares for the war in a surreal underground filled by parties, tragedies, love and hate.	170	1995	8.1	6
257	La haine	24 hours in the lives of three young men in the French suburbs the day after a violent riot.	98	1995	8.1	2
258	Dilwale Dulhania Le Jayenge	When Raj meets Simran in Europe, it isn't love at first sight but when Simran moves to India for an arranged marriage, love makes its presence felt.	189	1995	8.1	3
259	Before Sunrise	A young man and woman meet on a train in Europe, and wind up spending one evening together in Vienna. Unfortunately, both know that this will probably be their only night together.	101	1995	8.1	5
260	Trois couleurs: Rouge	A model discovers a retired judge is keen on invading people's privacy.	99	1994	8.1	3
261	Chung Hing sam lam	Two melancholy Hong Kong policemen fall in love: one with a mysterious female underworld figure, the other with a beautiful and ethereal server at a late-night restaurant he frequents.	102	1994	8.1	3
262	Jurassic Park	A pragmatic paleontologist visiting an almost complete theme park is tasked with protecting a couple of kids after a power failure causes the park's cloned dinosaurs to run loose.	127	1993	8.1	2
263	In the Name of the Father	A man's coerced confession to an I.R.A. bombing he did not commit results in the imprisonment of his father as well. An English lawyer fights to free them.	133	1993	8.1	2
264	Ba wang bie ji	Two boys meet at an opera training school in Peking in 1924. Their resulting friendship will span nearly 70 years and will endure some of the most troublesome times in China's history.	171	1993	8.1	5
265	Dà hóng denglong gaogao guà	A young woman becomes the fourth wife of a wealthy lord, and must learn to live with the strict rules and tensions within the household.	125	1991	8.1	7
266	Dead Poets Society	Maverick teacher John Keating uses poetry to embolden his boarding school students to new heights of self-expression.	128	1989	8.1	3
267	Stand by Me	After the death of one of his friends, a writer recounts a childhood journey with his friends to find the body of a missing boy.	89	1986	8.1	3
268	Platoon	Chris Taylor, a neophyte recruit in Vietnam, finds himself caught in a battle of wills between two sergeants, one good and the other evil. A shrewd examination of the brutality of war and the duality of man in conflict.	120	1986	8.1	1
269	Paris, Texas	Travis Henderson, an aimless drifter who has been missing for four years, wanders out of the desert and must reconnect with society, himself, his life, and his family.	145	1984	8.1	3
270	Kaze no tani no Naushika	Warrior and pacifist Princess Nausicaä desperately struggles to prevent two warring nations from destroying themselves and their dying planet.	117	1984	8.1	3
271	The Thing	A research team in Antarctica is hunted by a shape-shifting alien that assumes the appearance of its victims.	109	1982	8.1	1
272	Pink Floyd: The Wall	A confined but troubled rock star descends into madness in the midst of his physical and social isolation from everyone.	95	1982	8.1	2
273	Fitzcarraldo	The story of Brian Sweeney Fitzgerald, an extremely determined man who intends to build an opera house in the middle of a jungle.	158	1982	8.1	5
274	Fanny och Alexander	Two young Swedish children experience the many comedies and tragedies of their family, the Ekdahls.	188	1982	8.1	1
275	Blade Runner	A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.	117	1982	8.1	2
276	The Elephant Man	A Victorian surgeon rescues a heavily disfigured man who is mistreated while scraping a living as a side-show freak. Behind his monstrous façade, there is revealed a person of kindness, intelligence and sophistication.	124	1980	8.1	2
277	Life of Brian	Born on the original Christmas in the stable next door to Jesus Christ, Brian of Nazareth spends his life being mistaken for a messiah.	94	1979	8.1	5
278	The Deer Hunter	An in-depth examination of the ways in which the U.S. Vietnam War impacts and disrupts the lives of people in a small industrial town in Pennsylvania.	183	1978	8.1	1
279	Rocky	A small-time boxer gets a supremely rare chance to fight a heavy-weight champion in a bout in which he strives to go the distance for his self-respect.	120	1976	8.1	3
280	Network	A television network cynically exploits a deranged former anchor's ravings and revelations about the news media for its own profit.	121	1976	8.1	2
281	Barry Lyndon	An Irish rogue wins the heart of a rich widow and assumes her dead husband's aristocratic position in 18th-century England.	185	1975	8.1	7
282	Zerkalo	A dying man in his forties remembers his past. His childhood, his mother, the war, personal moments and things that tell of the recent history of all the Russian nation.	107	1975	8.1	8
283	Chinatown	A private detective hired to expose an adulterer finds himself caught up in a web of deceit, corruption, and murder.	130	1974	8.1	2
284	Paper Moon	During the Great Depression, a con man finds himself saddled with a young girl who may or may not be his daughter, and the two forge an unlikely partnership.	102	1973	8.1	3
285	Viskningar och rop	When a woman dying of cancer in early twentieth-century Sweden is visited by her two sisters, long-repressed feelings between the siblings rise to the surface.	91	1972	8.1	1
286	Solaris	A psychologist is sent to a station orbiting a distant planet in order to discover what has caused the crew to go insane.	167	1972	8.1	7
287	Le samouraï	After professional hitman Jef Costello is seen by witnesses his efforts to provide himself an alibi drive him further into a corner.	105	1967	8.1	14
288	Cool Hand Luke	A laid back Southern man is sentenced to two years in a rural prison, but refuses to conform.	127	1967	8.1	1
289	Persona	A nurse is put in charge of a mute actress and finds that their personae are melding together.	85	1966	8.1	6
290	Andrei Rublev	The life, times and afflictions of the fifteenth-century Russian iconographer St. Andrei Rublev.	205	1966	8.1	5
291	La battaglia di Algeri	In the 1950s, fear and violence escalate as the people of Algiers fight for independence from the French government.	121	1966	8.1	6
292	El ángel exterminador	The guests at an upper-class dinner party find themselves unable to leave.	95	1962	8.1	6
293	What Ever Happened to Baby Jane?	A former child star torments her paraplegic sister in their decaying Hollywood mansion.	134	1962	8.1	9
294	Sanjuro	A crafty samurai helps a young man and his fellow clansmen save his uncle, who has been framed and imprisoned by a corrupt superintendent.	96	1962	8.1	3
295	The Man Who Shot Liberty Valance	A senator returns to a western town for the funeral of an old friend and tells the story of his origins.	123	1962	8.1	6
296	Ivanovo detstvo	In WW2, twelve year old Soviet orphan Ivan Bondarev works for the Soviet army as a scout behind the German lines and strikes a friendship with three sympathetic Soviet officers.	95	1962	8.1	6
297	Jungfrukällan	An innocent yet pampered young virgin and her family's pregnant and jealous servant set out to deliver candles to church, but only one returns from events that transpire in the woods along the way.	89	1960	8.1	1
298	Inherit the Wind	Based on a real-life case in 1925, two great lawyers argue the case for and against a science teacher accused of the crime of teaching evolution.	128	1960	8.1	9
299	Les quatre cents coups	A young boy, left without attention, delves into a life of petty crime.	99	1959	8.1	6
300	Ben-Hur	After a Jewish prince is betrayed and sent into slavery by a Roman friend, he regains his freedom and comes back for revenge.	212	1959	8.1	3
301	Kakushi-toride no san-akunin	Lured by gold, two greedy peasants unknowingly escort a princess and her general across enemy lines.	139	1958	8.1	6
302	Le notti di Cabiria	A waifish prostitute wanders the streets of Rome looking for true love but finds only heartbreak.	110	1957	8.1	6
303	Kumonosu-jô	A war-hardened general, egged on by his ambitious wife, works to fulfill a prophecy that he would become lord of Spider's Web Castle.	110	1957	8.1	6
304	The Bridge on the River Kwai	British POWs are forced to build a railway bridge across the river Kwai for their Japanese captors, not knowing that the allied forces are planning to destroy it.	161	1957	8.1	7
305	On the Waterfront	An ex-prize fighter turned longshoreman struggles to stand up to his corrupt union bosses.	108	1954	8.1	1
306	Le salaire de la peur	In a decrepit South American village, four men are hired to transport an urgent nitroglycerine shipment without the equipment that would make it safe.	131	1953	8.1	3
307	Ace in the Hole	A frustrated former big-city journalist now stuck working for an Albuquerque newspaper exploits a story about a man trapped in a cave to rekindle his career, but the situation quickly escalates into an out-of-control circus.	111	1951	8.1	15
308	White Heat	A psychopathic criminal with a mother complex makes a daring break from prison and leads his old gang in a chemical plant payroll heist.	114	1949	8.1	6
309	The Third Man	Pulp novelist Holly Martins travels to shadowy, postwar Vienna, only to find himself investigating the mysterious death of an old friend, Harry Lime.	104	1949	8.1	15
310	The Red Shoes	A young ballet dancer is torn between the man she loves and her pursuit to become a prima ballerina.	135	1948	8.1	6
311	The Shop Around the Corner	Two employees at a gift shop can barely stand each other, without realizing that they are falling in love through the post as each other's anonymous pen pal.	99	1940	8.1	6
312	Rebecca	A self-conscious woman juggles adjusting to her new role as an aristocrat's wife and avoiding being intimidated by his first wife's spectral presence.	130	1940	8.1	15
313	Mr. Smith Goes to Washington	A naive man is appointed to fill a vacancy in the United States Senate. His plans promptly collide with political corruption, but he doesn't back down.	129	1939	8.1	9
314	Gone with the Wind	A manipulative woman and a roguish man conduct a turbulent romance during the American Civil War and Reconstruction periods.	238	1939	8.1	3
595	Kaze tachinu	A look at the life of Jiro Horikoshi, the man who designed Japanese fighter planes during World War II.	126	2013	7.8	4
315	La Grande Illusion	During WWI, two French soldiers are captured and imprisoned in a German P.O.W. camp. Several escape attempts follow until they are eventually sent to a seemingly inescapable fortress.	113	1937	8.1	6
316	It Happened One Night	A renegade reporter and a crazy young heiress meet on a bus heading for New York, and end up stuck with each other when the bus leaves them behind at one of the stops.	105	1934	8.1	15
317	La passion de Jeanne d'Arc	In 1431, Jeanne d'Arc is placed on trial on charges of heresy. The ecclesiastical jurists attempt to force Jeanne to recant her claims of holy visions.	110	1928	8.1	9
318	The Circus	The Tramp finds work and the girl of his dreams at a circus.	72	1928	8.1	9
319	Sunrise: A Song of Two Humans	An allegorical tale about a man fighting the good and evil within him. Both sides are made flesh - one a sophisticated woman he is attracted to and the other his wife.	94	1927	8.1	9
320	The General	When Union spies steal an engineer's beloved locomotive, he pursues it single-handedly and straight through enemy lines.	67	1926	8.1	9
321	Das Cabinet des Dr. Caligari	Hypnotist Dr. Caligari uses a somnambulist, Cesare, to commit murders.	76	1920	8.1	6
322	Badhaai ho	A man is embarrassed when he finds out his mother is pregnant.	124	2018	8	2
323	Togo	The story of Togo, the sled dog who led the 1925 serum run yet was considered by most to be too small and weak to lead such an intense race.	113	2019	8	3
324	Airlift	When Iraq invades Kuwait in August 1990, a callous Indian businessman becomes the spokesperson for more than 170,000 stranded countrymen.	130	2016	8	2
325	Bajrangi Bhaijaan	An Indian man with a magnanimous heart takes a young mute Pakistani girl back to her homeland to reunite her with her family.	163	2015	8	2
326	Baby	An elite counter-intelligence unit learns of a plot, masterminded by a maniacal madman. With the clock ticking, it's up to them to track the terrorists' international tentacles and prevent them from striking at the heart of India.	159	2015	8	2
327	La La Land	While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.	128	2016	8	1
328	Lion	A five-year-old Indian boy is adopted by an Australian couple after getting lost hundreds of kilometers from home. 25 years later, he sets out to find his lost family.	118	2016	8	3
329	The Martian	An astronaut becomes stranded on Mars after his team assume him dead, and must rely on his ingenuity to find a way to signal to Earth that he is alive.	144	2015	8	2
330	Zootopia	In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work together to uncover a conspiracy.	108	2016	8	3
331	Bãhubali: The Beginning	In ancient India, an adventurous and daring man becomes involved in a decades-old feud between two warring peoples.	159	2015	8	2
332	Kaguyahime no monogatari	Found inside a shining stalk of bamboo by an old bamboo cutter and his wife, a tiny girl grows rapidly into an exquisite young lady. The mysterious young princess enthralls all who encounter her, but ultimately she must confront her fate, the punishment for her crime.	137	2013	8	3
333	Wonder	Based on the New York Times bestseller, this movie tells the incredibly inspiring and heartwarming story of August Pullman, a boy with facial differences who enters the fifth grade, attending a mainstream elementary school for the first time.	113	2017	8	3
334	Gully Boy	A coming-of-age story based on the lives of street rappers in Mumbai.	154	2019	8	2
335	Special Chabbis	A gang of con-men rob prominent rich businessmen and politicians by posing as C.B.I and income tax officers.	144	2013	8	2
336	Short Term 12	A 20-something supervising staff member of a residential treatment facility navigates the troubled waters of that world alongside her co-worker and longtime boyfriend.	96	2013	8	5
337	Serbuan maut 2: Berandal	Only a short time after the first raid, Rama goes undercover with the thugs of Jakarta and plans to bring down the syndicate and uncover the corruption within his police force.	150	2014	8	1
338	The Imitation Game	During World War II, the English mathematical genius Alan Turing tries to crack the German Enigma code with help from fellow mathematicians.	114	2014	8	2
339	Guardians of the Galaxy	A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.	121	2014	8	2
340	Blade Runner 2049	Young Blade Runner K's discovery of a long-buried secret leads him to track down former Blade Runner Rick Deckard, who's been missing for thirty years.	164	2017	8	2
341	Her	In a near future, a lonely writer develops an unlikely relationship with an operating system designed to meet his every need.	126	2013	8	1
342	Bohemian Rhapsody	The story of the legendary British rock band Queen and lead singer Freddie Mercury, leading up to their famous performance at Live Aid (1985).	134	2018	8	2
343	The Revenant	A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team.	156	2015	8	1
344	The Perks of Being a Wallflower	An introvert freshman is taken under the wings of two seniors who welcome him to the real world	103	2012	8	2
345	Tropa de Elite 2: O Inimigo Agora é Outro	After a prison riot, former-Captain Nascimento, now a high ranking security officer in Rio de Janeiro, is swept into a bloody political dispute that involves government officials and paramilitary groups.	115	2010	8	6
346	The King's Speech	The story of King George VI, his impromptu ascension to the throne of the British Empire in 1936, and the speech therapist who helped the unsure monarch overcome his stammer.	118	2010	8	3
347	The Help	An aspiring author during the civil rights movement of the 1960s decides to write a book detailing the African American maids' point of view on the white families for which they work, and the hardships they go through on a daily basis.	146	2011	8	2
348	Deadpool	A wisecracking mercenary gets experimented on and becomes immortal but ugly, and sets out to track down the man who ruined his looks.	108	2016	8	5
349	Darbareye Elly	The mysterious disappearance of a kindergarten teacher during a picnic in the north of Iran is followed by a series of misadventures for her fellow travelers.	119	2009	8	16
350	Dev.D	After breaking up with his childhood sweetheart, a young man finds solace in drugs. Meanwhile, a teenage girl is caught in the world of prostitution. Will they be destroyed, or will they find redemption?	144	2009	8	1
351	Yip Man	During the Japanese invasion of China, a wealthy martial artist is forced to leave his home when his city is occupied. With little means of providing for themselves, Ip Man and the remaining members of the city must find a way to survive.	106	2008	8	5
352	My Name Is Khan	An Indian Muslim man with Asperger's syndrome takes a challenge to speak to the President of the United States seriously and embarks on a cross-country journey.	165	2010	8	2
353	Nefes: Vatan Sagolsun	Story of 40-man Turkish task force who must defend a relay station.	128	2009	8	6
354	Slumdog Millionaire	A Mumbai teenager reflects on his life after being accused of cheating on the Indian version of "Who Wants to be a Millionaire?".	120	2008	8	2
355	Black Swan	A committed dancer struggles to maintain her sanity after winning the lead role in a production of Tchaikovsky's "Swan Lake".	108	2010	8	1
356	Tropa de Elite	In 1997 Rio de Janeiro, Captain Nascimento has to find a substitute for his position while trying to take down drug dealers and criminals before the Pope visits.	115	2007	8	5
357	The Avengers	Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.	143	2012	8	2
358	Persepolis	A precocious and outspoken Iranian girl grows up during the Islamic Revolution.	96	2007	8	4
359	Dallas Buyers Club	In 1985 Dallas, electrician and hustler Ron Woodroof works around the system to help AIDS patients get the medication they need after he is diagnosed with the disease.	117	2013	8	5
360	The Pursuit of Happyness	A struggling salesman takes custody of his son as he's poised to begin a life-changing professional career.	117	2006	8	3
361	Blood Diamond	A fisherman, a smuggler, and a syndicate of businessmen match wits over the possession of a priceless diamond.	143	2006	8	1
362	The Bourne Ultimatum	Jason Bourne dodges a ruthless C.I.A. official and his Agents from a new assassination program while searching for the origins of his life as a trained killer.	115	2007	8	2
363	Bin-jip	A transient young man breaks into empty homes to partake of the vacationing residents' lives for a few days.	88	2004	8	3
364	Sin City	A movie that explores the dark and miserable town, Basin City, tells the story of three different people, all caught up in violent corruption.	124	2005	8	1
365	Le scaphandre et le papillon	The true story of Elle editor Jean-Dominique Bauby who suffers a stroke and has to live with an almost totally paralyzed body; only his left eye isn't paralyzed.	112	2007	8	4
366	G.O.R.A.	A slick young Turk kidnapped by extraterrestrials shows his great « humanitarian spirit » by outwitting the evil commander-in-chief of the planet of G.O.R.A.	127	2004	8	6
367	Ratatouille	A rat who can cook makes an unusual alliance with a young kitchen worker at a famous restaurant.	111	2007	8	3
368	Casino Royale	After earning 00 status and a licence to kill, Secret Agent James Bond sets out on his first mission as 007. Bond must defeat a private banker funding terrorists in a high-stakes game of poker at Casino Royale, Montenegro.	144	2006	8	4
369	Kill Bill: Vol. 2	The Bride continues her quest of vengeance against her former boss and lover Bill, the reclusive bouncer Budd, and the treacherous, one-eyed Elle.	137	2004	8	1
370	Vozvrashchenie	In the Russian wilderness, two brothers face a range of new, conflicting emotions when their father - a man they know only through a single photograph - resurfaces.	110	2003	8	6
371	Bom Yeoareum Gaeul Gyeoul Geurigo Bom	A boy is raised by a Buddhist monk in an isolated floating temple where the years pass like the seasons.	103	2003	8	5
372	Mar adentro	The factual story of Spaniard Ramon Sampedro, who fought a thirty-year campaign in favor of euthanasia and his own right to die.	126	2014	8	3
373	Cinderella Man	The story of James J. Braddock, a supposedly washed-up boxer who came back to become a champion and an inspiration in the 1930s.	144	2005	8	2
374	Kal Ho Naa Ho	Naina, an introverted, perpetually depressed girl's life changes when she meets Aman. But Aman has a secret of his own which changes their lives forever. Embroiled in all this is Rohit, Naina's best friend who conceals his love for her.	186	2003	8	3
375	Mou gaan dou	A story between a mole in the police department and an undercover cop. Their objectives are the same: to find out who is the mole, and who is the cop.	101	2002	8	2
376	Pirates of the Caribbean: The Curse of the Black Pearl	Blacksmith Will Turner teams up with eccentric pirate "Captain" Jack Sparrow to save his love, the governor's daughter, from Jack's former pirate allies, who are now undead.	143	2003	8	2
377	Big Fish	A frustrated son tries to determine the fact from fiction in his dying father's life.	125	2003	8	3
378	The Incredibles	A family of undercover superheroes, while trying to live the quiet suburban life, are forced into action to save the world.	115	2004	8	3
379	Yeopgijeogin geunyeo	A young man sees a drunk, cute woman standing too close to the tracks at a metro station in Seoul and pulls her back. She ends up getting him into trouble repeatedly after that, starting on the train.	137	2001	8	6
380	Dogville	A woman on the run from the mob is reluctantly accepted in a small Colorado community in exchange for labor, but when a search visits the town she finds out that their support has a price.	178	2003	8	5
381	Vizontele	Lives of residents in a small Anatolian village change when television is introduced to them	110	2001	8	6
382	Donnie Darko	After narrowly escaping a bizarre accident, a troubled teenager is plagued by visions of a man in a large rabbit suit who manipulates him to commit a series of crimes.	113	2001	8	5
383	Magnolia	An epic mosaic of interrelated characters in search of love, forgiveness, and meaning in the San Fernando Valley.	188	1999	8	5
384	Dancer in the Dark	An East European girl travels to the United States with her young son, expecting it to be like a Hollywood film.	140	2000	8	3
385	The Straight Story	An old man makes a long journey by lawnmower to mend his relationship with an ill brother.	112	1999	8	3
386	Pâfekuto burû	A pop singer gives up her career to become an actress, but she slowly goes insane when she starts being stalked by an obsessed fan and what seems to be a ghost of her past.	81	1997	8	1
387	Festen	At Helge's 60th birthday party, some unpleasant family truths are revealed.	105	1998	8	5
388	Central do Brasil	An emotive journey of a former school teacher, who writes letters for illiterate people, and a young boy, whose mother has just died, as they search for the father he never knew.	110	1998	8	5
389	The Iron Giant	A young boy befriends a giant robot from outer space that a paranoid government agent wants to destroy.	86	1999	8	7
390	Knockin' on Heaven's Door	Two terminally ill patients escape from a hospital, steal a car and rush towards the sea.	87	1997	8	6
391	Sling Blade	Karl Childers, a simple man hospitalized since his childhood murder of his mother and her lover, is released to start a new life in a small town.	135	1996	8	5
392	Secrets & Lies	Following the death of her adoptive parents, a successful young black optometrist establishes contact with her biological mother -- a lonely white factory worker living in poverty in East London.	136	1996	8	3
393	Twelve Monkeys	In a future world devastated by disease, a convict is sent back in time to gather information about the man-made virus that wiped out most of the human population on the planet.	129	1995	8	1
394	Kôkaku Kidôtai	A cyborg policewoman and her partner hunt a mysterious and powerful hacker called the Puppet Master.	83	1995	8	2
395	The Nightmare Before Christmas	Jack Skellington, king of Halloween Town, discovers Christmas Town, but his attempts to bring Christmas to his home causes confusion.	76	1993	8	3
396	Groundhog Day	A weatherman finds himself inexplicably living the same day over and over again.	101	1993	8	3
397	Bound by Honor	Based on the true life experiences of poet Jimmy Santiago Baca, the film focuses on step-brothers Paco and Cruz, and their bi-racial cousin Miklo.	180	1993	8	5
398	Scent of a Woman	A prep school student needing money agrees to "babysit" a blind man, but the job is not at all what he anticipated.	156	1992	8	2
399	Aladdin	A kindhearted street urchin and a power-hungry Grand Vizier vie for a magic lamp that has the power to make their deepest wishes come true.	90	1992	8	3
400	JFK	New Orleans District Attorney Jim Garrison discovers there's more to the Kennedy assassination than the official story.	189	1991	8	2
401	Beauty and the Beast	A prince cursed to spend his days as a hideous monster sets out to regain his humanity by earning a young woman's love.	84	1991	8	8
402	Dances with Wolves	Lieutenant John Dunbar, assigned to a remote western Civil War outpost, befriends wolves and Indians, making him an intolerable aberration in the military.	181	1990	8	3
403	Do the Right Thing	On the hottest day of the year on a street in the Bedford-Stuyvesant section of Brooklyn, everyone's hate and bigotry smolders and builds until it explodes into violence.	120	1989	8	5
404	Rain Man	Selfish yuppie Charlie Babbitt's father left a fortune to his savant brother Raymond and a pittance to Charlie; they travel cross-country.	133	1988	8	3
405	Akira	A secret military project endangers Neo-Tokyo when it turns a biker gang member into a rampaging psychic psychopath who can only be stopped by two teenagers and a group of psychics.	124	1988	8	2
406	The Princess Bride	While home sick in bed, a young boy's grandfather reads him the story of a farmboy-turned-pirate who encounters numerous obstacles, enemies and allies in his quest to be reunited with his true love.	98	1987	8	3
407	Der Himmel über Berlin	An angel tires of overseeing human activity and wishes to become human when he falls in love with a mortal.	128	1987	8	3
408	Au revoir les enfants	A French boarding school run by priests seems to be a haven from World War II until a new student arrives. He becomes the roommate of the top student in his class. Rivals at first, the roommates form a bond and share a secret.	104	1987	8	3
409	Tenkû no shiro Rapyuta	A young boy and a girl with a magic crystal must race against pirates and foreign agents in a search for a legendary floating castle.	125	1986	8	3
410	The Terminator	A human soldier is sent from 2029 to 1984 to stop an almost indestructible cyborg killing machine, sent from the same year, which has been programmed to execute a young woman whose unborn son is the key to humanity's future salvation.	107	1984	8	2
411	Gandhi	The life of the lawyer who became the famed leader of the Indian revolts against the British rule through his philosophy of nonviolent protest.	191	1982	8	3
412	Kagemusha	A petty thief with an utter resemblance to a samurai warlord is hired as the lord's double. When the warlord later dies the thief is forced to take up arms in his place.	180	1980	8	3
413	Being There	A simpleminded, sheltered gardener becomes an unlikely trusted advisor to a powerful businessman and an insider in Washington politics.	130	1979	8	7
414	Annie Hall	Neurotic New York comedian Alvy Singer falls in love with the ditzy Annie Hall.	93	1977	8	1
415	Jaws	When a killer shark unleashes chaos on a beach community, it's up to a local sheriff, a marine biologist, and an old seafarer to hunt the beast down.	124	1975	8	1
416	Dog Day Afternoon	Three amateur bank robbers plan to hold up a bank. A nice simple robbery: Walk in, take the money, and run. Unfortunately, the supposedly uncomplicated heist suddenly becomes a bizarre nightmare as everything that could go wrong does.	125	1975	8	3
417	Young Frankenstein	An American grandson of the infamous scientist, struggling to prove that his grandfather was not as insane as people believe, is invited to Transylvania, where he discovers the process that reanimates a dead body.	106	1974	8	1
418	Papillon	A man befriends a fellow criminal as the two of them begin serving their sentence on a dreadful prison island, which inspires the man to plot his escape.	151	1973	8	5
419	The Exorcist	When a 12-year-old girl is possessed by a mysterious entity, her mother seeks the help of two priests to save her.	122	1973	8	1
420	Sleuth	A man who loves games and theater invites his wife's lover to meet him, setting up a battle of wits with potentially deadly results.	138	1972	8	7
421	The Last Picture Show	In 1951, a group of high schoolers come of age in a bleak, isolated, atrophied North Texas town that is slowly dying, both culturally and economically.	118	1971	8	5
422	Fiddler on the Roof	In prerevolutionary Russia, a Jewish peasant contends with marrying off three of his daughters while growing anti-Semitic sentiment threatens his village.	181	1971	8	8
423	Il conformista	A weak-willed Italian man becomes a fascist flunky who goes abroad to arrange the assassination of his old teacher, now a political dissident.	113	1970	8	2
424	Butch Cassidy and the Sundance Kid	Wyoming, early 1900s. Butch Cassidy and The Sundance Kid are the leaders of a band of outlaws. After a train robbery goes wrong they find themselves on the run with a posse hard on their heels. Their solution - escape to Bolivia.	110	1969	8	7
425	Rosemary's Baby	A young couple trying for a baby move into a fancy apartment surrounded by peculiar neighbors.	137	1968	8	1
426	Planet of the Apes	An astronaut crew crash-lands on a planet in the distant future where intelligent talking apes are the dominant species, and humans are the oppressed and enslaved.	112	1968	8	3
427	The Graduate	A disillusioned college graduate finds himself torn between his older lover and her daughter.	106	1967	8	1
428	Who's Afraid of Virginia Woolf?	A bitter, aging couple, with the help of alcohol, use their young houseguests to fuel anguish and emotional pain towards each other over the course of a distressing night.	131	1966	8	1
429	The Sound of Music	A woman leaves an Austrian convent to become a governess to the children of a Naval officer widower.	172	1965	8	3
430	Doctor Zhivago	The life of a Russian physician and poet who, although married to another, falls in love with a political activist's wife and experiences hardship during World War I and then the October Revolution.	197	1965	8	1
431	Per un pugno di dollari	A wandering gunfighter plays two rival families against each other in a town torn apart by greed, pride, and revenge.	99	1964	8	1
432	8½	A harried movie director retreats into his memories and fantasies.	138	1963	8	6
433	Vivre sa vie: Film en douze tableaux	Twelve episodic tales in the life of a Parisian woman and her slow descent into prostitution.	80	1962	8	6
434	The Hustler	An up-and-coming pool player plays a long-time champion in a single high-stakes match.	134	1961	8	1
435	La dolce vita	A series of stories following a week in the life of a philandering paparazzo journalist living in Rome.	174	1960	8	1
436	Rio Bravo	A small-town sheriff in the American West enlists the help of a cripple, a drunk, and a young gunfighter in his efforts to hold in jail the brother of the local bad guy.	141	1959	8	9
437	Anatomy of a Murder	In a murder trial, the defendant says he suffered temporary insanity after the victim raped his wife. What is the truth, and will he win his case?	161	1959	8	6
438	Touch of Evil	A stark, perverse story of murder, kidnapping, and police corruption in a Mexican border town.	95	1958	8	4
439	Cat on a Hot Tin Roof	Brick is an alcoholic ex-football player who drinks his days away and resists the affections of his wife. A reunion with his terminal father jogs a host of memories and revelations for both father and son.	108	1958	8	1
440	Sweet Smell of Success	Powerful but unethical Broadway columnist J.J. Hunsecker coerces unscrupulous press agent Sidney Falco into breaking up his sister's romance with a jazz musician.	96	1957	8	15
441	The Killing	Crook Johnny Clay assembles a five man team to plan and execute a daring race-track robbery.	84	1956	8	15
442	The Night of the Hunter	A religious fanatic marries a gullible widow whose young children are reluctant to tell him where their real daddy hid the $10,000 he'd stolen in a robbery.	92	1955	8	6
443	La Strada	A care-free girl is sold to a traveling entertainer, consequently enduring physical and emotional pain along the way.	108	1954	8	6
444	Les diaboliques	The wife and mistress of a loathed school principal plan to murder him with what they believe is the perfect alibi.	117	1955	8	6
445	Stalag 17	When two escaping American World War II prisoners are killed, the German P.O.W. camp barracks black marketeer, J.J. Sefton, is suspected of being an informer.	120	1953	8	6
446	Roman Holiday	A bored and sheltered princess escapes her guardians and falls in love with an American newsman in Rome.	118	1953	8	6
447	A Streetcar Named Desire	Disturbed Blanche DuBois moves in with her sister in New Orleans and is tormented by her brutish brother-in-law while her reality crumbles around her.	122	1951	8	1
448	In a Lonely Place	A potentially violent screenwriter is a murder suspect until his lovely neighbor clears him. However, she soon starts to have her doubts.	94	1950	8	6
449	Kind Hearts and Coronets	A distant poor relative of the Duke D'Ascoyne plots to inherit the title by murdering the eight other heirs who stand ahead of him in the line of succession.	106	1949	8	3
450	Rope	Two men attempt to prove they committed the perfect crime by hosting a dinner party after strangling their former classmate to death.	80	1948	8	1
451	Out of the Past	A private eye escapes his past to run a gas station in a small town, but his past catches up with him. Now he must return to the big city world of danger, corruption, double crosses and duplicitous dames.	97	1947	8	6
452	Brief Encounter	Meeting a stranger in a railway station, a woman is tempted to cheat on her husband.	86	1945	8	3
453	Laura	A police detective falls in love with the woman whose murder he is investigating.	88	1944	8	9
454	The Best Years of Our Lives	Three World War II veterans return home to small-town America to discover that they and their families have been irreparably changed.	170	1946	8	15
455	Arsenic and Old Lace	A writer of books on the futility of marriage risks his reputation when he decides to get married. Things get even more complicated when he learns on his wedding day that his beloved maiden aunts are habitual murderers.	118	1942	8	6
456	The Maltese Falcon	A private detective takes on a case that involves him with three eccentric criminals, a gorgeous liar, and their quest for a priceless statuette.	100	1941	8	6
457	The Grapes of Wrath	A poor Midwest family is forced off their land. They travel to California, suffering the misfortunes of the homeless in the Great Depression.	129	1940	8	9
458	The Wizard of Oz	Dorothy Gale is swept away from a farm in Kansas to a magical land of Oz in a tornado and embarks on a quest with her new friends to see the Wizard who can help her return home to Kansas and help her friends as well.	102	1939	8	3
459	La règle du jeu	A bourgeois life in France at the onset of World War II, as the rich and their poor servants meet up at a French chateau.	110	1939	8	6
460	The Thin Man	Former detective Nick Charles and his wealthy wife Nora investigate a murder case, mostly for the fun of it.	91	1934	8	16
461	All Quiet on the Western Front	A German youth eagerly enters World War I, but his enthusiasm wanes as he gets a firsthand view of the horror.	152	1930	8	3
462	Bronenosets Potemkin	In the midst of the Russian Revolution of 1905, the crew of the battleship Potemkin mutiny against the brutal, tyrannical regime of the vessel's officers. The resulting street demonstration in Odessa brings on a police massacre.	75	1925	8	6
463	Knives Out	A detective investigates the death of a patriarch of an eccentric, combative family.	130	2019	7.9	2
464	Dil Bechara	The emotional journey of two hopelessly in love youngsters, a young girl, Kizie, suffering from cancer, and a boy, Manny, whom she meets at a support group.	101	2020	7.9	2
465	Manbiki kazoku	A family of small-time crooks take in a child they find outside in the cold.	121	2018	7.9	1
466	Marriage Story	Noah Baumbach's incisive and compassionate look at a marriage breaking up and a family staying together.	137	2019	7.9	3
467	Call Me by Your Name	In 1980s Italy, romance blossoms between a seventeen-year-old student and the older man hired as his father's research assistant.	132	2017	7.9	2
468	I, Daniel Blake	After having suffered a heart-attack, a 59-year-old carpenter must fight the bureaucratic forces of the system in order to receive Employment and Support Allowance.	100	2016	7.9	2
469	Isle of Dogs	Set in Japan, Isle of Dogs follows a boy's odyssey in search of his lost dog.	101	2018	7.9	3
470	Hunt for the Wilderpeople	A national manhunt is ordered for a rebellious kid and his foster uncle who go missing in the wild New Zealand bush.	101	2016	7.9	2
471	Captain Fantastic	In the forests of the Pacific Northwest, a father devoted to raising his six kids with a rigorous physical and intellectual education is forced to leave his paradise and enter the world, challenging his idea of what it means to be a parent.	118	2016	7.9	5
472	Sing Street	A boy growing up in Dublin during the 1980s escapes his strained family life by starting a band to impress the mysterious girl he likes.	106	2016	7.9	4
473	Thor: Ragnarok	Imprisoned on the planet Sakaar, Thor must race against time to return to Asgard and stop Ragnarök, the destruction of his world, at the hands of the powerful and ruthless villain Hela.	130	2017	7.9	2
474	Nightcrawler	When Louis Bloom, a con man desperate for work, muscles into the world of L.A. crime journalism, he blurs the line between observer and participant to become the star of his own story.	117	2014	7.9	1
475	Jojo Rabbit	A young boy in Hitler's army finds out his mother is hiding a Jewish girl in their home.	108	2019	7.9	2
476	Arrival	A linguist works with the military to communicate with alien lifeforms after twelve mysterious spacecrafts appear around the world.	116	2016	7.9	2
477	Star Wars: Episode VII - The Force Awakens	As a new threat to the galaxy rises, Rey, a desert scavenger, and Finn, an ex-stormtrooper, must join Han Solo and Chewbacca to search for the one hope of restoring peace.	138	2015	7.9	3
478	Before Midnight	We meet Jesse and Celine nine years on in Greece. Almost two decades have passed since their first meeting on that train bound for Vienna.	109	2013	7.9	5
479	X-Men: Days of Future Past	The X-Men send Wolverine to the past in a desperate effort to change history and prevent an event that results in doom for both humans and mutants.	132	2014	7.9	2
480	Bir Zamanlar Anadolu'da	A group of men set out in search of a dead body in the Anatolian steppes.	157	2011	7.9	6
481	The Artist	An egomaniacal film star develops a relationship with a young dancer against the backdrop of Hollywood's silent era.	100	2011	7.9	3
482	Edge of Tomorrow	A soldier fighting aliens gets to relive the same day over and over again, the day restarting every time he dies.	113	2014	7.9	2
483	Amour	Georges and Anne are an octogenarian couple. They are cultivated, retired music teachers. Their daughter, also a musician, lives in Britain with her family. One day, Anne has a stroke, and the couple's bond of love is severely tested.	127	2012	7.9	2
484	The Irishman	An old man recalls his time painting houses for his friend, Jimmy Hoffa, through the 1950-70s.	209	2019	7.9	5
485	Un prophète	A young Arab man is sent to a French prison.	155	2009	7.9	1
486	Moon	Astronaut Sam Bell has a quintessentially personal encounter toward the end of his three-year stint on the Moon, where he, working alongside his computer, GERTY, sends back to Earth parcels of a resource that has helped diminish our planet's power problems.	97	2009	7.9	5
487	Låt den rätte komma in	Oskar, an overlooked and bullied boy, finds love and revenge through Eli, a beautiful but peculiar girl.	114	2008	7.9	5
488	District 9	Violence ensues after an extraterrestrial race forced to live in slum-like conditions on Earth finds a kindred spirit in a government agent exposed to their biotechnology.	112	2009	7.9	1
489	The Wrestler	A faded professional wrestler must retire, but finds his quest for a new life outside the ring a dispiriting struggle.	109	2008	7.9	2
490	Jab We Met	A depressed wealthy businessman finds his life changing after he meets a spunky and care-free young woman.	138	2007	7.9	3
491	Boyhood	The life of Mason, from early childhood to his arrival at college.	165	2014	7.9	1
492	4 luni, 3 saptamâni si 2 zile	A woman assists her friend in arranging an illegal abortion in 1980s Romania.	113	2007	7.9	6
493	Star Trek	The brash James T. Kirk tries to live up to his father's legacy with Mr. Spock keeping him in check as a vengeful Romulan from the future creates black holes to destroy the Federation one planet at a time.	127	2009	7.9	2
494	In Bruges	Guilt-stricken after a job gone wrong, hitman Ray and his partner await orders from their ruthless boss in Bruges, Belgium, the last place in the world Ray wants to be.	107	2008	7.9	5
495	The Man from Earth	An impromptu goodbye party for Professor John Oldman becomes a mysterious interrogation after the retiring scholar reveals to his colleagues he has a longer and stranger past than they can imagine.	87	2007	7.9	6
496	Letters from Iwo Jima	The story of the battle of Iwo Jima between the United States and Imperial Japan during World War II, as told from the perspective of the Japanese who fought it.	141	2006	7.9	2
497	The Fall	In a hospital on the outskirts of 1920s Los Angeles, an injured stuntman begins to tell a fellow patient, a little girl with a broken arm, a fantastic story of five mythical heroes. Thanks to his fractured state of mind and her vivid imagination, the line between fiction and reality blurs as the tale advances.	117	2006	7.9	5
498	Life of Pi	A young man who survives a disaster at sea is hurtled into an epic journey of adventure and discovery. While cast away, he forms an unexpected connection with another survivor: a fearsome Bengal tiger.	127	2012	7.9	3
499	Fantastic Mr. Fox	An urbane fox cannot resist returning to his farm raiding ways and then must help his community survive the farmers' retaliation.	87	2009	7.9	7
500	C.R.A.Z.Y.	A young French-Canadian, growing up in the 1960s and 1970s, struggles to reconcile his emerging homosexuality with his father's conservative values and his own Catholic beliefs.	129	2005	7.9	6
501	Les choristes	The new teacher at a severely administered boys' boarding school works to positively affect the students' lives through music.	97	2004	7.9	4
502	Iron Man	After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.	126	2008	7.9	2
503	Shaun of the Dead	A man's uneventful life is disrupted by the zombie apocalypse.	99	2004	7.9	2
504	Gegen die Wand	With the intention to break free from the strict familial restrictions, a suicidal young woman sets up a marriage of convenience with a forty-year-old addict, an act that will lead to an outburst of envious love.	121	2004	7.9	5
505	Mystic River	The lives of three men who were childhood friends are shattered when one of them has a family tragedy.	138	2003	7.9	1
506	Harry Potter and the Prisoner of Azkaban	Harry Potter, Ron and Hermione return to Hogwarts School of Witchcraft and Wizardry for their third year of study, where they delve into the mystery surrounding an escaped prisoner who poses a dangerous threat to the young wizard.	142	2004	7.9	3
507	Ying xiong	A defense officer, Nameless, was summoned by the King of Qin regarding his success of terminating three warriors.	120	2002	7.9	4
508	Hable con ella	Two men share an odd friendship while they care for two women who are both in deep comas.	112	2002	7.9	5
509	No Man's Land	Bosnia and Herzegovina during 1993 at the time of the heaviest fighting between the two warring sides. Two soldiers from opposing sides in the conflict, Nino and Ciki, become trapped in no man's land, whilst a third soldier becomes a living booby trap.	98	2001	7.9	5
510	Cowboy Bebop: Tengoku no tobira	A terrorist explosion releases a deadly virus on the masses, and it's up the bounty-hunting Bebop crew to catch the cold-blooded culprit.	115	2001	7.9	3
511	The Bourne Identity	A man is picked up by a fishing boat, bullet-riddled and suffering from amnesia, before racing to elude assassins and attempting to regain his memory.	119	2002	7.9	2
512	Nueve reinas	Two con artists try to swindle a stamp collector by selling him a sheet of counterfeit rare stamps (the "nine queens").	114	2000	7.9	5
513	Children of Men	In 2027, in a chaotic world in which women have become somehow infertile, a former activist agrees to help transport a miraculously pregnant woman to a sanctuary at sea.	109	2006	7.9	1
514	Almost Famous	A high-school boy is given the chance to write a story for Rolling Stone Magazine about an up-and-coming rock band as he accompanies them on their concert tour.	122	2000	7.9	1
515	Mulholland Dr.	After a car wreck on the winding Mulholland Drive renders a woman amnesiac, she and a perky Hollywood-hopeful search for clues and answers across Los Angeles in a twisting venture beyond dreams and reality.	147	2001	7.9	5
516	Toy Story 2	When Woody is stolen by a toy collector, Buzz and his friends set out on a rescue mission to save Woody before he becomes a museum toy property with his roundup gang Jessie, Prospector, and Bullseye.	92	1999	7.9	3
517	Boogie Nights	Back when sex was safe, pleasure was a business and business was booming, an idealistic porn producer aspires to elevate his craft to an art when he discovers a hot young talent.	155	1997	7.9	5
518	Mimi wo sumaseba	A love story between a girl who loves reading books, and a boy who has previously checked out all of the library books she chooses.	111	1995	7.9	3
519	Once Were Warriors	A family descended from Maori warriors is bedeviled by a violent father and the societal problems of being treated as outcasts.	102	1994	7.9	1
520	True Romance	In Detroit, a lonely pop culture geek marries a call girl, steals cocaine from her pimp, and tries to sell it in Hollywood. Meanwhile, the owners of the cocaine, the Mob, track them down in an attempt to reclaim it.	119	1993	7.9	5
521	Trois couleurs: Bleu	A woman struggles to find a way to live her life after the death of her husband and child.	94	1993	7.9	3
522	Jûbê ninpûchô	A vagabond swordsman is aided by a beautiful ninja girl and a crafty spy in confronting a demonic clan of killers - with a ghost from his past as their leader - who are bent on overthrowing the Tokugawa Shogunate.	94	1993	7.9	1
523	Carlito's Way	A Puerto Rican former convict, just released from prison, pledges to stay away from drugs and violence despite the pressure around him and lead on to a better life outside of N.Y.C.	144	1993	7.9	1
524	Edward Scissorhands	An artificial man, who was incompletely constructed and has scissors for hands, leads a solitary life. Then one day, a suburban lady meets him and introduces him to her world.	105	1990	7.9	3
525	My Left Foot: The Story of Christy Brown	Christy Brown, born with cerebral palsy, learns to paint and write with his only controllable limb - his left foot.	103	1989	7.9	3
526	Crimes and Misdemeanors	An ophthalmologist's mistress threatens to reveal their affair to his wife while a married documentary filmmaker is infatuated with another woman.	104	1989	7.9	4
527	The Untouchables	During the era of Prohibition in the United States, Federal Agent Eliot Ness sets out to stop ruthless Chicago gangster Al Capone and, because of rampant corruption, assembles a small, hand-picked team to help him.	119	1987	7.9	1
528	Hannah and Her Sisters	Between two Thanksgivings two years apart, Hannah's husband falls in love with her sister Lee, while her hypochondriac ex-husband rekindles his relationship with her sister Holly.	107	1986	7.9	4
529	Brazil	A bureaucrat in a dystopic society becomes an enemy of the state as he pursues the woman of his dreams.	132	1985	7.9	3
530	This Is Spinal Tap	Spinal Tap, one of England's loudest bands, is chronicled by film director Marty DiBergi on what proves to be a fateful tour.	82	1984	7.9	5
531	A Christmas Story	In the 1940s, a young boy named Ralphie attempts to convince his parents, his teacher and Santa that a Red Ryder BB gun really is the perfect Christmas gift.	93	1983	7.9	3
532	The Blues Brothers	Jake Blues, just released from prison, puts together his old band to save the Catholic home where he and his brother Elwood were raised.	133	1980	7.9	3
533	Manhattan	The life of a divorced television writer dating a teenage girl is further complicated when he falls in love with his best friend's mistress.	96	1979	7.9	5
534	All That Jazz	Director/choreographer Bob Fosse tells his own life story as he details the sordid career of Joe Gideon, a womanizing, drug-using dancer.	123	1979	7.9	1
535	Dawn of the Dead	Following an ever-growing epidemic of zombies that have risen from the dead, two Philadelphia S.W.A.T. team members, a traffic reporter, and his television executive girlfriend seek refuge in a secluded shopping mall.	127	1978	7.9	1
536	All the President's Men	"The Washington Post" reporters Bob Woodward and Carl Bernstein uncover the details of the Watergate scandal that leads to President Richard Nixon's resignation.	138	1976	7.9	3
537	La montaña sagrada	In a corrupt, greed-fueled world, a powerful alchemist leads a messianic character and seven materialistic figures to the Holy Mountain, where they hope to achieve enlightenment.	114	1973	7.9	5
538	Amarcord	A series of comedic and nostalgic vignettes set in a 1930s Italian coastal town.	123	1973	7.9	5
539	Le charme discret de la bourgeoisie	A surreal, virtually plotless series of dreams centered around six middle-class people and their consistently interrupted attempts to have a meal together.	102	1972	7.9	7
540	Aguirre, der Zorn Gottes	In the 16th century, the ruthless and insane Don Lope de Aguirre leads a Spanish expedition in search of El Dorado.	95	1972	7.9	6
541	Harold and Maude	Young, rich, and obsessed with death, Harold finds himself changed forever when he meets lively septuagenarian Maude at a funeral.	91	1971	7.9	7
542	Patton	The World War II phase of the career of controversial American general George S. Patton.	172	1970	7.9	3
543	The Wild Bunch	An aging group of outlaws look for one last big score as the "traditional" American West is disappearing around them.	145	1969	7.9	1
544	Night of the Living Dead	A ragtag group of Pennsylvanians barricade themselves in an old farmhouse to remain safe from a horde of flesh-eating ghouls that are ravaging the East Coast of the United States.	96	1968	7.9	6
545	The Lion in Winter	1183 A.D.: King Henry II's three sons all want to inherit the throne, but he won't commit to a choice. They and his wife variously plot to force him.	134	1968	7.9	7
546	In the Heat of the Night	A black police detective is asked to investigate a murder in a racially hostile southern town.	110	1967	7.9	3
547	Charade	Romance and suspense ensue in Paris as a woman is pursued by several men who want a fortune her murdered husband had stolen. Whom can she trust?	113	1963	7.9	3
548	The Manchurian Candidate	A former prisoner of war is brainwashed as an unwitting assassin for an international Communist conspiracy.	126	1962	7.9	4
549	Spartacus	The slave Spartacus leads a violent revolt against the decadent Roman Republic.	197	1960	7.9	1
550	L'avventura	A woman disappears during a Mediterranean boating trip. During the search, her lover and her best friend become attracted to each other.	144	1960	7.9	3
551	Hiroshima mon amour	A French actress filming an anti-war film in Hiroshima has an affair with a married Japanese architect as they share their differing perspectives on war.	90	1959	7.9	6
552	The Ten Commandments	Moses, an Egyptian Prince, learns of his true heritage as a Hebrew and his divine mission as the deliverer of his people.	220	1956	7.9	3
553	The Searchers	An American Civil War veteran embarks on a journey to rescue his niece from the Comanches.	119	1956	7.9	9
554	East of Eden	Two brothers struggle to maintain their strict, Bible-toting father's favor.	118	1955	7.9	3
555	High Noon	A town Marshal, despite the disagreements of his newlywed bride and the townspeople around him, must face a gang of deadly killers alone at high noon when the gang leader, an outlaw he sent up years ago, arrives on the noon train.	85	1952	7.9	7
556	Strangers on a Train	A psychopath forces a tennis star to comply with his theory that two strangers can get away with murder.	101	1951	7.9	1
557	Harvey	Due to his insistence that he has an invisible six foot-tall rabbit for a best friend, a whimsical middle-aged man is thought by his family to be insane - but he may be wiser than anyone knows.	104	1950	7.9	15
558	Miracle on 34th Street	When a nice old man who claims to be Santa Claus is institutionalized as insane, a young lawyer decides to defend him by arguing in court that he is the real thing.	96	1947	7.9	6
559	Notorious	A woman is asked to spy on a group of Nazi friends in South America. How far will she have to go to ingratiate herself with them?	102	1946	7.9	3
560	The Big Sleep	Private detective Philip Marlowe is hired by a wealthy family. Before the complex case is over, he's seen murder, blackmail, and what might be love.	114	1946	7.9	9
561	The Lost Weekend	The desperate life of a chronic alcoholic is followed through a four-day drinking bout.	101	1945	7.9	9
562	The Philadelphia Story	When a rich woman's ex-husband and a tabloid-type reporter turn up just before her planned remarriage, she begins to learn the truth about herself.	112	1940	7.9	6
563	His Girl Friday	A newspaper editor uses every trick in the book to keep his ace reporter ex-wife from remarrying.	92	1940	7.9	9
564	The Adventures of Robin Hood	When Prince John and the Norman Lords begin oppressing the Saxon masses in King Richard's absence, a Saxon lord fights back as the outlaw leader of a rebel guerrilla army.	102	1938	7.9	7
565	A Night at the Opera	A sly business manager and two wacky friends of two opera singers help them achieve success while humiliating their stuffy and snobbish enemies.	96	1935	7.9	9
566	King Kong	A film crew goes to a tropical island for an exotic location shoot and discovers a colossal ape who takes a shine to their female blonde star. He is then captured and brought back to New York City for public exhibition.	100	1933	7.9	9
567	Freaks	A circus' beautiful trapeze artist agrees to marry the leader of side-show performers, but his deformed friends discover she is only marrying him for his inheritance.	64	1932	7.9	6
568	Nosferatu	Vampire Count Orlok expresses interest in a new residence and real estate agent Hutter's wife.	94	1922	7.9	6
569	The Gentlemen	An American expat tries to sell off his highly profitable marijuana empire in London, triggering plots, schemes, bribery and blackmail in an attempt to steal his domain out from under him.	113	2019	7.8	1
570	Raazi	A Kashmiri woman agrees to marry a Pakistani army officer in order to spy on Pakistan during the Indo-Pakistan War of 1971.	138	2018	7.8	2
571	Sound of Metal	A heavy-metal drummer's life is thrown into freefall when he begins to lose his hearing.	120	2019	7.8	5
572	Forushande	While both participating in a production of "Death of a Salesman," a teacher's wife is assaulted in her new home, which leaves him determined to find the perpetrator over his wife's traumatized objections.	124	2016	7.8	2
573	Dunkirk	Allied soldiers from Belgium, the British Empire, and France are surrounded by the German Army and evacuated during a fierce battle in World War II.	106	2017	7.8	2
574	Perfetti sconosciuti	Seven long-time friends get together for a dinner. When they decide to share with each other the content of every text message, email and phone call they receive, many secrets start to unveil and the equilibrium trembles.	96	2016	7.8	6
575	Hidden Figures	The story of a team of female African-American mathematicians who served a vital role in NASA during the early years of the U.S. space program.	127	2016	7.8	2
576	Paddington 2	Paddington (Ben Whishaw), now happily settled with the Brown family and a popular member of the local community, picks up a series of odd jobs to buy the perfect present for his Aunt Lucy's (Imelda Staunton's) 100th birthday, only for the gift to be stolen.	103	2017	7.8	3
577	Udta Punjab	A story that revolves around drug abuse in the affluent north Indian State of Punjab and how the youth there have succumbed to it en-masse resulting in a socio-economic decline.	148	2016	7.8	1
578	Kubo and the Two Strings	A young boy named Kubo must locate a magical suit of armour worn by his late father in order to defeat a vengeful spirit from the past.	101	2016	7.8	7
579	M.S. Dhoni: The Untold Story	The untold story of Mahendra Singh Dhoni's journey from ticket collector to trophy collector - the world-cup-winning captain of the Indian Cricket Team.	184	2016	7.8	3
580	Manchester by the Sea	A depressed uncle is asked to take care of his teenage nephew after the boy's father dies.	137	2016	7.8	2
581	Under sandet	In post-World War II Denmark, a group of young German POWs are forced to clear a beach of thousands of land mines under the watch of a Danish Sergeant who slowly learns to appreciate their plight.	100	2015	7.8	5
582	Rogue One	The daughter of an Imperial scientist joins the Rebel Alliance in a risky move to steal the plans for the Death Star.	133	2016	7.8	2
583	Captain America: Civil War	Political involvement in the Avengers' affairs causes a rift between Captain America and Iron Man.	147	2016	7.8	2
584	The Hateful Eight	In the dead of a Wyoming winter, a bounty hunter and his prisoner find shelter in a cabin currently inhabited by a collection of nefarious characters.	168	2015	7.8	1
585	Little Women	Jo March reflects back and forth on her life, telling the beloved story of the March sisters - four young women, each determined to live life on her own terms.	135	2019	7.8	3
586	Loving Vincent	In a story depicted in oil painted animation, a young man comes to the last hometown of painter Vincent van Gogh (Robert Gulaczyk) to deliver the troubled artist's final letter and ends up investigating his final days there.	94	2017	7.8	2
587	Pride	U.K. gay activists work to help miners during their lengthy strike of the National Union of Mineworkers in the summer of 1984.	119	2014	7.8	5
588	Le passé	An Iranian man deserts his French wife and her two children to return to his homeland. Meanwhile, his wife starts up a new relationship, a reality her husband confronts upon his wife's request for a divorce.	130	2013	7.8	4
589	La grande bellezza	Jep Gambardella has seduced his way through the lavish nightlife of Rome for decades, but after his 65th birthday and a shock from the past, Jep looks past the nightclubs and parties to find a timeless landscape of absurd, exquisite beauty.	141	2013	7.8	6
590	The Lunchbox	A mistaken delivery in Mumbai's famously efficient lunchbox delivery system connects a young housewife to an older man in the dusk of his life as they build a fantasy world together through notes in the lunchbox.	104	2013	7.8	3
591	Vicky Donor	A man is brought in by an infertility doctor to supply him with his sperm, where he becomes the biggest sperm donor for his clinic.	126	2012	7.8	2
592	Big Hero 6	A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up with a group of friends to form a band of high-tech heroes.	102	2014	7.8	3
593	About Time	At the age of 21, Tim discovers he can travel in time and change what happens and has happened in his own life. His decision to make his world a better place by getting a girlfriend turns out not to be as easy as you might think.	123	2013	7.8	5
594	English Vinglish	A quiet, sweet tempered housewife endures small slights from her well-educated husband and daughter every day because of her inability to speak and understand English.	134	2012	7.8	3
596	Toy Story 4	When a new toy called "Forky" joins Woody and the gang, a road trip alongside old and new friends reveals how big the world can be for a toy.	100	2019	7.8	3
597	La migliore offerta	A lonely art expert working for a mysterious and reclusive heiress finds not only her art worth examining.	131	2013	7.8	5
598	Moonrise Kingdom	A pair of young lovers flee their New England town, which causes a local search party to fan out to find them.	94	2012	7.8	1
599	How to Train Your Dragon 2	When Hiccup and Toothless discover an ice cave that is home to hundreds of new wild dragons and the mysterious Dragon Rider, the two friends find themselves at the center of a battle to protect the peace.	102	2014	7.8	3
600	The Big Short	In 2006-2007 a group of investors bet against the US mortgage market. In their research they discover how flawed and corrupt the market is.	130	2015	7.8	1
601	Kokuhaku	A psychological thriller of a grieving mother turned cold-blooded avenger with a twisty master plan to pay back those who were responsible for her daughter's death.	106	2010	7.8	6
602	Ang-ma-reul bo-at-da	A secret agent exacts revenge on a serial killer through a series of captures and releases.	144	2010	7.8	6
603	The Girl with the Dragon Tattoo	Journalist Mikael Blomkvist is aided in his search for a woman who has been missing for forty years by Lisbeth Salander, a young computer hacker.	158	2011	7.8	5
604	Captain Phillips	The true story of Captain Richard Phillips and the 2009 hijacking by Somali pirates of the U.S.-flagged MV Maersk Alabama, the first American cargo ship to be hijacked in two hundred years.	134	2013	7.8	2
605	Ajeossi	A quiet pawnshop keeper with a violent past takes on a drug-and-organ trafficking ring in hope of saving the child who is his only friend.	119	2010	7.8	5
606	Straight Outta Compton	The rap group NWA emerges from the mean streets of Compton in Los Angeles, California, in the mid-1980s and revolutionizes Hip Hop culture with their music and tales about life in the hood.	147	2015	7.8	5
607	Madeo	A mother desperately searches for the killer who framed her son for a girl's horrific murder.	129	2009	7.8	5
608	Chugyeokja	A disgraced ex-policeman who runs a small ring of prostitutes finds himself in a race against time when one of his women goes missing.	125	2008	7.8	6
609	The Hobbit: The Desolation of Smaug	The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring.	161	2013	7.8	2
610	Das weiße Band - Eine deutsche Kindergeschichte	Strange events happen in a small village in the north of Germany during the years before World War I, which seem to be ritual punishment. Who is responsible?	144	2009	7.8	2
611	Män som hatar kvinnor	A journalist is aided by a young female hacker in his search for the killer of a woman who has been dead for forty years.	152	2009	7.8	5
612	The Trial of the Chicago 7	The story of 7 people on trial stemming from various charges surrounding the uprising at the 1968 Democratic National Convention in Chicago, Illinois.	129	2020	7.8	5
613	Druk	Four friends, all high school teachers, test a theory that they will improve their lives by maintaining a constant level of alcohol in their blood.	117	2020	7.8	6
614	The Fighter	Based on the story of Micky Ward, a fledgling boxer who tries to escape the shadow of his more famous but troubled older boxing brother and get his own shot at greatness.	116	2010	7.8	2
615	Taken	A retired CIA agent travels across Europe and relies on his old skills to save his estranged daughter, who has been kidnapped while on a trip to Paris.	90	2008	7.8	1
616	The Boy in the Striped Pyjamas	Through the innocent eyes of Bruno, the eight-year-old son of the commandant at a German concentration camp, a forbidden friendship with a Jewish boy on the other side of the camp fence has startling and unexpected consequences.	94	2008	7.8	4
617	Once	A modern-day musical about a busker and an immigrant and their eventful week in Dublin, as they write, rehearse and record songs that tell their love story.	86	2007	7.8	5
618	The Hobbit: An Unexpected Journey	A reluctant Hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home, and the gold within it from the dragon Smaug.	169	2012	7.8	2
619	Auf der anderen Seite	A Turkish man travels to Istanbul to find the daughter of his father's former girlfriend.	122	2007	7.8	6
620	Atonement	Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit.	123	2007	7.8	5
621	Drive	A mysterious Hollywood stuntman and mechanic moonlights as a getaway driver and finds himself in trouble when he helps out his neighbor.	100	2011	7.8	1
622	American Gangster	An outcast New York City cop is charged with bringing down Harlem drug lord Frank Lucas, whose real life inspired this partly biographical film.	157	2007	7.8	1
623	Avatar	A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.	162	2009	7.8	2
624	Mr. Nobody	A boy stands on a station platform as a train is about to leave. Should he go with his mother or stay with his father? Infinite possibilities arise from this decision. As long as he doesn't choose, anything is possible.	141	2009	7.8	5
625	Apocalypto	As the Mayan kingdom faces its decline, a young man is taken on a perilous journey to a world ruled by fear and oppression.	139	2006	7.8	1
626	Little Miss Sunshine	A family determined to get their young daughter into the finals of a beauty pageant take a cross-country trip in their VW bus.	101	2006	7.8	2
627	Hot Fuzz	A skilled London police officer is transferred to a small town with a dark secret.	121	2007	7.8	2
628	The Curious Case of Benjamin Button	Tells the story of Benjamin Button, a man who starts aging backwards with consequences.	166	2008	7.8	2
629	Veer-Zaara	Veer-Zaara is a saga of love, separation, courage and sacrifice. A love story that is an inspiration and will remain a legend forever.	192	2004	7.8	3
630	Adams æbler	A neo-nazi sentenced to community service at a church clashes with the blindly devotional priest.	94	2005	7.8	5
631	Pride & Prejudice	Sparks fly when spirited Elizabeth Bennet meets single, rich, and proud Mr. Darcy. But Mr. Darcy reluctantly finds himself falling in love with a woman beneath his class. Can each overcome their own pride and prejudice?	129	2005	7.8	7
632	The World's Fastest Indian	The story of New Zealander Burt Munro, who spent years rebuilding a 1920 Indian motorcycle, which helped him set the land speed world record at Utah's Bonneville Salt Flats in 1967.	127	2005	7.8	3
633	Tôkyô goddofâzâzu	On Christmas Eve, three homeless people living on the streets of Tokyo discover a newborn baby among the trash and set out to find its parents.	90	2003	7.8	2
634	Serenity	The crew of the ship Serenity try to evade an assassin sent to recapture one of their members who is telepathic.	119	2005	7.8	4
635	Walk the Line	A chronicle of country music legend Johnny Cash's life, from his early days on an Arkansas cotton farm to his rise to fame with Sun Records in Memphis, where he recorded alongside Elvis Presley, Jerry Lee Lewis, and Carl Perkins.	136	2005	7.8	4
636	Ondskan	A teenage boy expelled from school for fighting arrives at a boarding school where the systematic bullying of younger students is encouraged as a means to maintain discipline, and decides to fight back.	113	2003	7.8	6
637	The Notebook	A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom, but they are soon separated because of their social differences.	123	2004	7.8	1
638	Diarios de motocicleta	The dramatization of a motorcycle road trip Che Guevara went on in his youth that showed him his life's calling.	126	2004	7.8	3
639	Lilja 4-ever	Sixteen-year-old Lilja and her only friend, the young boy Volodja, live in Russia, fantasizing about a better life. One day, Lilja falls in love with Andrej, who is going to Sweden, and invites Lilja to come along and start a new life.	109	2002	7.8	5
640	Les triplettes de Belleville	When her grandson is kidnapped during the Tour de France, Madame Souza and her beloved pooch Bruno team up with the Belleville Sisters--an aged song-and-dance team from the days of Fred Astaire--to rescue him.	80	2003	7.8	4
641	Gongdong gyeongbi guyeok JSA	After a shooting incident at the North/South Korean border/DMZ leaves 2 North Korean soldiers dead, a neutral Swiss/Swedish team investigates, what actually happened.	110	2000	7.8	6
642	The Count of Monte Cristo	A young man, falsely imprisoned by his jealous "friend", escapes and uses a hidden treasure to exact his revenge.	131	2002	7.8	4
643	Waking Life	A man shuffles through a dream meeting various people and discussing the meanings and purposes of the universe.	99	2001	7.8	5
644	Remember the Titans	The true story of a newly appointed African-American coach and his high school team on their first season as a racially integrated unit.	113	2000	7.8	3
645	Wo hu cang long	A young Chinese warrior steals a sword from a famed swordsman and then escapes into a world of romantic adventure with a mysterious man in the frontier of the nation.	120	2000	7.8	2
646	Todo sobre mi madre	Young Esteban wants to become a writer and also to discover the identity of his second mother, a trans woman, carefully concealed by his mother Manuela.	101	1999	7.8	5
647	Cast Away	A FedEx executive undergoes a physical and emotional transformation after crash landing on a deserted island.	143	2000	7.8	2
648	The Boondock Saints	Two Irish Catholic brothers become vigilantes and wipe out Boston's criminal underworld in the name of God.	108	1999	7.8	5
649	The Insider	A research chemist comes under personal and professional attack when he decides to appear in a 60 Minutes exposé on Big Tobacco.	157	1999	7.8	2
650	October Sky	The true story of Homer Hickam, a coal miner's son who was inspired by the first Sputnik launch to take up rocketry against his father's wishes.	108	1999	7.8	7
651	Shrek	A mean lord exiles fairytale creatures to the swamp of a grumpy ogre, who must go on a quest and rescue a princess for the lord in order to get his land back.	90	2001	7.8	3
652	Titanic	A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.	194	1997	7.8	2
653	Hana-bi	Nishi leaves the police in the face of harrowing personal and professional difficulties. Spiraling into depression, he makes questionable decisions.	103	1997	7.8	6
654	Gattaca	A genetically inferior man assumes the identity of a superior one in order to pursue his lifelong dream of space travel.	106	1997	7.8	2
655	The Game	After a wealthy banker is given an opportunity to participate in a mysterious game, his life is turned upside down when he becomes unable to distinguish between the game and reality.	129	1997	7.8	2
656	Breaking the Waves	Oilman Jan is paralyzed in an accident. His wife, who prayed for his return, feels guilty; even more, when Jan urges her to have sex with another.	159	1996	7.8	5
657	Ed Wood	Ambitious but troubled movie director Edward D. Wood Jr. tries his best to fulfill his dreams, despite his lack of talent.	127	1994	7.8	3
658	What's Eating Gilbert Grape	A young man in a small Midwestern town struggles to care for his mentally-disabled younger brother and morbidly obese mother while attempting to pursue his own happiness.	118	1993	7.8	3
659	Tombstone	A successful lawman's plans to retire anonymously in Tombstone, Arizona are disrupted by the kind of outlaws he was famous for eliminating.	130	1993	7.8	5
660	The Sandlot	In the summer of 1962, a new kid in town is taken under the wing of a young baseball prodigy and his rowdy team, resulting in many adventures.	101	1993	7.8	3
661	The Remains of the Day	A butler who sacrificed body and soul to service in the years leading up to World War II realizes too late how misguided his loyalty was to his lordly employer.	134	1993	7.8	3
662	Naked	Parallel tales of two sexually obsessed men, one hurting and annoying women physically and mentally, one wandering around the city talking to strangers and experiencing dimensions of life.	132	1993	7.8	6
663	The Fugitive	Dr. Richard Kimble, unjustly accused of murdering his wife, must find the real killer while being the target of a nationwide manhunt led by a seasoned U.S. Marshal.	130	1993	7.8	3
664	A Bronx Tale	A father becomes worried when a local gangster befriends his son in the Bronx in the 1960s.	121	1993	7.8	5
665	Batman: Mask of the Phantasm	Batman is wrongly implicated in a series of murders of mob bosses actually done by a new vigilante assassin.	76	1993	7.8	7
666	Lat sau san taam	A tough-as-nails cop teams up with an undercover agent to shut down a sinister mobster and his crew.	128	1992	7.8	5
667	Night on Earth	An anthology of 5 different cab drivers in 5 American and European cities and their remarkable fares on the same eventful night.	129	1991	7.8	5
668	La double vie de Véronique	Two parallel stories about two identical women; one living in Poland, the other in France. They don't know each other, but their lives are nevertheless profoundly connected.	98	1991	7.8	5
669	Boyz n the Hood	Follows the lives of three young males living in the Crenshaw ghetto of Los Angeles, dissecting questions of race, relationships, violence, and future prospects.	112	1991	7.8	1
670	Misery	After a famous author is rescued from a car crash by a fan of his novels, he comes to realize that the care he is receiving is only the beginning of a nightmare of captivity and abuse.	107	1990	7.8	5
671	Awakenings	The victims of an encephalitis epidemic many years ago have been catatonic ever since, but now a new drug offers the prospect of reviving them.	121	1990	7.8	3
672	Majo no takkyûbin	A young witch, on her mandatory year of independent life, finds fitting into a new community difficult while she supports herself by running an air courier service.	103	1989	7.8	3
673	Glory	Robert Gould Shaw leads the U.S. Civil War's first all-black volunteer company, fighting prejudices from both his own Union Army, and the Confederates.	122	1989	7.8	5
674	Dip huet seung hung	A disillusioned assassin accepts one last hit in hopes of using his earnings to restore vision to a singer he accidentally blinded.	111	1989	7.8	5
675	Back to the Future Part II	After visiting 2015, Marty McFly must repeat his visit to 1955 to prevent disastrous changes to 1985...without interfering with his first trip.	108	1989	7.8	3
676	Mississippi Burning	Two F.B.I. Agents with wildly different styles arrive in Mississippi to investigate the disappearance of some civil rights activists.	128	1988	7.8	1
677	Predator	A team of commandos on a mission in a Central American jungle find themselves hunted by an extraterrestrial warrior.	107	1987	7.8	1
678	Evil Dead II	The lone survivor of an onslaught of flesh-possessing spirits holes up in a cabin with a group of strangers while the demons continue their attack.	84	1987	7.8	1
679	Ferris Bueller's Day Off	A high school wise guy is determined to have a day off from school, despite what the Principal thinks of that.	103	1986	7.8	3
680	Down by Law	Two men are framed and sent to jail, where they meet a murderer who helps them escape and leave the state.	107	1986	7.8	5
681	The Goonies	A group of young misfits called The Goonies discover an ancient map and set out on an adventure to find a legendary pirate's long-lost treasure.	114	1985	7.8	3
682	The Color Purple	A black Southern woman struggles to find her identity after suffering abuse from her father and others over four decades.	154	1985	7.8	3
683	The Breakfast Club	Five high school students meet in Saturday detention and discover how they have a lot more in common than they thought.	97	1985	7.8	2
684	The Killing Fields	A journalist is trapped in Cambodia during tyrant Pol Pot's bloody 'Year Zero' cleansing campaign, which claimed the lives of two million 'undesirable' civilians.	141	1984	7.8	2
685	Ghostbusters	Three former parapsychology professors set up shop as a unique ghost removal service.	105	1984	7.8	2
686	The Right Stuff	The story of the original Mercury 7 astronauts and their macho, seat-of-the-pants approach to the space program.	193	1983	7.8	7
687	The King of Comedy	Rupert Pupkin is a passionate yet unsuccessful comic who craves nothing more than to be in the spotlight and to achieve this, he stalks and kidnaps his idol to take the spotlight for himself.	109	1982	7.8	3
688	E.T. the Extra-Terrestrial	A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.	115	1982	7.8	3
689	Kramer vs. Kramer	Ted Kramer's wife leaves him, allowing for a lost bond to be rediscovered between Ted and his son, Billy. But a heated custody battle ensues over the divorced couple's son, deepening the wounds left by the separation.	105	1979	7.8	1
690	Days of Heaven	A hot-tempered farm laborer convinces the woman he loves to marry their rich but dying boss so that they can have a claim to his fortune.	94	1978	7.8	7
691	The Outlaw Josey Wales	Missouri farmer Josey Wales joins a Confederate guerrilla unit and winds up on the run from the Union soldiers who murdered his family.	135	1976	7.8	1
692	The Man Who Would Be King	Two British former soldiers decide to set themselves up as Kings in Kafiristan, a land where no white man has set foot since Alexander the Great.	129	1975	7.8	7
693	The Conversation	A paranoid, secretive surveillance expert has a crisis of conscience when he suspects that the couple he is spying on will be murdered.	113	1974	7.8	3
694	La planète sauvage	On a faraway planet where blue giants rule, oppressed humanoids rebel against their machine-like leaders.	72	1973	7.8	3
695	The Day of the Jackal	A professional assassin codenamed "Jackal" plots to kill Charles de Gaulle, the President of France.	143	1973	7.8	1
696	Badlands	An impressionable teenage girl from a dead-end town and her older greaser boyfriend embark on a killing spree in the South Dakota badlands.	94	1973	7.8	7
697	Cabaret	A female girlie club entertainer in Weimar Republic era Berlin romances two men while the Nazi Party rises to power around them.	124	1972	7.8	1
698	Willy Wonka & the Chocolate Factory	A poor but hopeful boy seeks one of the five coveted golden tickets that will send him on a tour of Willy Wonka's mysterious chocolate factory.	100	1971	7.8	3
699	Midnight Cowboy	A naive hustler travels from Texas to New York City to seek personal fortune, finding a new friend in the process.	113	1969	7.8	1
700	Wait Until Dark	A recently blinded woman is terrorized by a trio of thugs while they search for a heroin-stuffed doll they believe is in her apartment.	108	1967	7.8	6
701	Guess Who's Coming to Dinner	A couple's attitudes are challenged when their daughter introduces them to her African-American fiancé.	108	1967	7.8	6
702	Bonnie and Clyde	Bored waitress Bonnie Parker falls in love with an ex-con named Clyde Barrow and together they start a violent crime spree through the country, stealing cars and robbing banks.	111	1967	7.8	1
703	My Fair Lady	Snobbish phonetics Professor Henry Higgins agrees to a wager that he can make flower girl Eliza Doolittle presentable in high society.	170	1964	7.8	3
704	Mary Poppins	In turn of the century London, a magical nanny employs music and adventure to help two neglected children become closer to their father.	139	1964	7.8	3
705	The Longest Day	The events of D-Day, told on a grand scale from both the Allied and German points of view.	178	1962	7.8	8
706	Jules et Jim	Decades of a love triangle concerning two friends and an impulsive woman.	105	1962	7.8	6
707	The Innocents	A young governess for two children becomes convinced that the house and grounds are haunted.	100	1961	7.8	1
708	À bout de souffle	A small-time thief steals a car and impulsively murders a motorcycle policeman. Wanted by the authorities, he reunites with a hip American journalism student and attempts to persuade her to run away with him to Italy.	90	1960	7.8	3
709	Red River	Dunson leads a cattle drive, the culmination of over 14 years of work, to its destination in Missouri. But his tyrannical behavior along the way causes a mutiny, led by his adopted son.	133	1948	7.8	9
710	Key Largo	A man visits his war buddy's family hotel and finds a gangster running things. As a hurricane approaches, the two end up confronting each other.	100	1948	7.8	6
711	To Have and Have Not	During World War II, American expatriate Harry Morgan helps transport a French Resistance leader and his beautiful wife to Martinique while romancing a sensuous lounge singer.	100	1944	7.8	7
712	Shadow of a Doubt	A young girl, overjoyed when her favorite uncle comes to visit the family, slowly begins to suspect that he is in fact the "Merry Widow" killer sought by the authorities.	108	1943	7.8	7
713	Stagecoach	A group of people traveling on a stagecoach find their journey complicated by the threat of Geronimo and learn something about each other in the process.	96	1939	7.8	9
714	The Lady Vanishes	While travelling in continental Europe, a rich young playgirl realizes that an elderly lady seems to have disappeared from the train.	96	1938	7.8	6
715	Bringing Up Baby	While trying to secure a $1 million donation for his museum, a befuddled paleontologist is pursued by a flighty and often irritating heiress and her pet leopard, Baby.	102	1938	7.8	9
716	Bride of Frankenstein	Mary Shelley reveals the main characters of her novel survived: Dr. Frankenstein, goaded by an even madder scientist, builds his monster a mate.	75	1935	7.8	6
717	Duck Soup	Rufus T. Firefly is named president/dictator of bankrupt Freedonia and declares war on neighboring Sylvania over the love of wealthy Mrs. Teasdale.	69	1933	7.8	6
718	Scarface: The Shame of the Nation	An ambitious and nearly insane violent gangster climbs the ladder of success in the mob, but his weaknesses prove to be his downfall.	93	1932	7.8	7
719	Frankenstein	Dr. Frankenstein dares to tamper with life and death by creating a human monster out of lifeless body parts.	70	1931	7.8	9
720	Roma	A year in the life of a middle-class family's maid in Mexico City in the early 1970s.	135	2018	7.7	5
721	God's Own Country	Spring. Yorkshire. Young farmer Johnny Saxby numbs his daily frustrations with binge drinking and casual sex, until the arrival of a Romanian migrant worker for lambing season ignites an intense relationship that sets Johnny on a new path.	104	2017	7.7	6
722	Deadpool 2	Foul-mouthed mutant mercenary Wade Wilson (a.k.a. Deadpool), brings together a team of fellow mutant rogues to protect a young boy with supernatural abilities from the brutal, time-traveling cyborg Cable.	119	2018	7.7	5
723	Wind River	A veteran hunter helps an FBI agent investigate the murder of a young woman on a Wyoming Native American reservation.	107	2017	7.7	5
724	Get Out	A young African-American visits his white girlfriend's parents for the weekend, where his simmering uneasiness about their reception of him eventually reaches a boiling point.	104	2017	7.7	5
725	Mission: Impossible - Fallout	Ethan Hunt and his IMF team, along with some familiar allies, race against time after a mission gone wrong.	147	2018	7.7	2
726	En man som heter Ove	Ove, an ill-tempered, isolated retiree who spends his days enforcing block association rules and visiting his wife's grave, has finally given up on life just as an unlikely friendship develops with his boisterous new neighbors.	116	2015	7.7	4
727	What We Do in the Shadows	Viago, Deacon and Vladislav are vampires who are finding that modern life has them struggling with the mundane - like paying rent, keeping up with the chore wheel, trying to get into nightclubs and overcoming flatmate conflicts.	86	2014	7.7	5
728	Omoide no Mânî	Due to 12 y.o. Anna's asthma, she's sent to stay with relatives of her guardian in the Japanese countryside. She likes to be alone, sketching. She befriends Marnie. Who is the mysterious, blonde Marnie.	103	2014	7.7	3
729	The Theory of Everything	A look at the relationship between the famous physicist Stephen Hawking and his wife.	123	2014	7.7	3
730	Kingsman: The Secret Service	A spy organisation recruits a promising street kid into the agency's training program, while a global threat emerges from a twisted tech genius.	129	2014	7.7	1
731	The Fault in Our Stars	Two teenage cancer patients begin a life-affirming journey to visit a reclusive author in Amsterdam.	126	2014	7.7	2
732	Me and Earl and the Dying Girl	High schooler Greg, who spends most of his time making parodies of classic movies with his co-worker Earl, finds his outlook forever altered after befriending a classmate who has just been diagnosed with cancer.	105	2015	7.7	4
733	Birdman or (The Unexpected Virtue of Ignorance)	A washed-up superhero actor attempts to revive his fading career by writing, directing, and starring in a Broadway production.	119	2014	7.7	1
734	La vie d'Adèle	Adèle's life is changed when she meets Emma, a young woman with blue hair, who will allow her to discover desire and to assert herself as a woman and as an adult. In front of others, Adèle grows, seeks herself, loses herself, and ultimately finds herself through love and loss.	180	2013	7.7	1
735	Kai po che!	Three friends growing up in India at the turn of the millennium set out to open a training academy to produce the country's next cricket stars.	130	2013	7.7	3
736	The Broken Circle Breakdown	Elise and Didier fall in love at first sight, in spite of their differences. He talks, she listens. He's a romantic atheist, she's a religious realist. When their daughter becomes seriously ill, their love is put on trial.	111	2012	7.7	6
737	Captain America: The Winter Soldier	As Steve Rogers struggles to embrace his role in the modern world, he teams up with a fellow Avenger and S.H.I.E.L.D agent, Black Widow, to battle a new threat from history: an assassin known as the Winter Soldier.	136	2014	7.7	2
738	Rockstar	Janardhan Jakhar chases his dreams of becoming a big Rock star, during which he falls in love with Heer.	159	2011	7.7	2
739	Nebraska	An aging, booze-addled father makes the trip from Montana to Nebraska with his estranged son in order to claim a million-dollar Mega Sweepstakes Marketing prize.	115	2013	7.7	2
740	Wreck-It Ralph	A video game villain wants to be a hero and sets out to fulfill his dream, but his quest brings havoc to the whole arcade where he lives.	101	2012	7.7	3
741	Le Petit Prince	A little girl lives in a very grown-up world with her mother, who tries to prepare her for it. Her neighbor, the Aviator, introduces the girl to an extraordinary world where anything is possible, the world of the Little Prince.	108	2015	7.7	7
742	Detachment	A substitute teacher who drifts from classroom to classroom finds a connection to the students and teachers during his latest assignment.	98	2011	7.7	6
743	Midnight in Paris	While on a trip to Paris with his fiancée's family, a nostalgic screenwriter finds himself mysteriously going back to the 1920s every day at midnight.	96	2011	7.7	4
744	The Lego Movie	An ordinary LEGO construction worker, thought to be the prophesied as "special", is recruited to join a quest to stop an evil tyrant from gluing the LEGO universe into eternal stasis.	100	2014	7.7	3
745	Gravity	Two astronauts work together to survive after an accident leaves them stranded in space.	91	2013	7.7	2
746	Star Trek Into Darkness	After the crew of the Enterprise find an unstoppable force of terror from within their own organization, Captain Kirk leads a manhunt to a war-zone world to capture a one-man weapon of mass destruction.	132	2013	7.7	2
747	Beasts of No Nation	A drama based on the experiences of Agu, a child soldier fighting in the civil war of an unnamed African country.	137	2015	7.7	6
748	The Social Network	As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.	120	2010	7.7	2
749	X: First Class	In the 1960s, superpowered humans Charles Xavier and Erik Lensherr work together to find others like them, but Erik's vengeful pursuit of an ambitious mutant who ruined his life causes a schism to divide them.	131	2011	7.7	2
750	The Hangover	Three buddies wake up from a bachelor party in Las Vegas, with no memory of the previous night and the bachelor missing. They make their way around the city in order to find their friend before his wedding.	100	2009	7.7	2
751	Skyfall	James Bond's loyalty to M is tested when her past comes back to haunt her. When MI6 comes under attack, 007 must track down and destroy the threat, no matter how personal the cost.	143	2012	7.7	2
752	Silver Linings Playbook	After a stint in a mental institution, former teacher Pat Solitano moves back in with his parents and tries to reconcile with his ex-wife. Things get more challenging when Pat meets Tiffany, a mysterious girl with problems of her own.	122	2012	7.7	1
753	Argo	Acting under the cover of a Hollywood producer scouting a location for a science fiction film, a CIA agent launches a dangerous operation to rescue six Americans in Tehran during the U.S. hostage crisis in Iran in 1979.	120	2012	7.7	1
754	(500) Days of Summer	An offbeat romantic comedy about a woman who doesn't believe true love exists, and the young man who falls for her.	95	2009	7.7	2
755	Harry Potter and the Deathly Hallows: Part 1	As Harry, Ron, and Hermione race against time and evil to destroy the Horcruxes, they uncover the existence of the three most powerful objects in the wizarding world: the Deathly Hallows.	146	2010	7.7	1
756	Gake no ue no Ponyo	A five-year-old boy develops a relationship with Ponyo, a young goldfish princess who longs to become a human after falling in love with him.	101	2008	7.7	3
757	Frost/Nixon	A dramatic retelling of the post-Watergate television interviews between British talk-show host David Frost and former president Richard Nixon.	122	2008	7.7	5
758	Papurika	When a machine that allows therapists to enter their patients' dreams is stolen, all Hell breaks loose. Only a young female therapist, Paprika, can stop it.	90	2006	7.7	3
759	Changeling	Grief-stricken mother Christine Collins (Angelina Jolie) takes on the L.A.P.D. to her own detriment when it tries to pass off an obvious impostor as her missing child.	141	2008	7.7	5
760	Flipped	Two eighth-graders start to have feelings for each other despite being total opposites.	90	2010	7.7	7
761	Toki o kakeru shôjo	A high-school girl named Makoto acquires the power to travel back in time, and decides to use it for her own personal benefits. Little does she know that she is affecting the lives of others just as much as she is her own.	98	2006	7.7	3
762	Death Note: Desu nôto	A battle between the world's two greatest minds begins when Light Yagami finds the Death Note, a notebook with the power to kill, and decides to rid the world of criminals.	126	2006	7.7	6
763	This Is England	A young boy becomes friends with a gang of skinheads. Friends soon become like family, and relationships will be pushed to the very limit.	101	2006	7.7	6
764	Ex Machina	A young programmer is selected to participate in a ground-breaking experiment in synthetic intelligence by evaluating the human qualities of a highly advanced humanoid A.I.	108	2014	7.7	2
765	Efter brylluppet	A manager of an orphanage in India is sent to Copenhagen, Denmark, where he discovers a life-altering family secret.	120	2006	7.7	5
766	The Last King of Scotland	Based on the events of the brutal Ugandan dictator Idi Amin's regime as seen by his personal physician during the 1970s.	123	2006	7.7	5
767	Zodiac	In the late 1960s/early 1970s, a San Francisco cartoonist becomes an amateur detective obsessed with tracking down the Zodiac Killer, an unidentified individual who terrorizes Northern California with a killing spree.	157	2007	7.7	2
768	Lucky Number Slevin	A case of mistaken identity lands Slevin into the middle of a war being plotted by two of the city's most rival crime bosses. Under constant surveillance by Detective Brikowski and assassin Goodkat, he must get them before they get him.	110	2006	7.7	5
769	Joyeux Noël	In December 1914, an unofficial Christmas truce on the Western Front allows soldiers from opposing sides of the First World War to gain insight into each other's way of life.	116	2005	7.7	4
770	Control	A profile of Ian Curtis, the enigmatic singer of Joy Division whose personal, professional, and romantic troubles led him to commit suicide at the age of 23.	122	2007	7.7	5
771	Tangled	The magically long-haired Rapunzel has spent her entire life in a tower, but now that a runaway thief has stumbled upon her, she is about to discover the world for the first time, and who she really is.	100	2010	7.7	3
772	Zwartboek	In the Nazi-occupied Netherlands during World War II, a Jewish singer infiltrates the regional Gestapo headquarters for the Dutch resistance.	145	2006	7.7	5
773	Brokeback Mountain	The story of a forbidden and secretive relationship between two cowboys, and their lives over the years.	134	2005	7.7	1
774	3:10 to Yuma	A small-time rancher agrees to hold a captured outlaw who's awaiting a train to go to court in Yuma. A battle of wills ensues as the outlaw tries to psych out the rancher.	122	2007	7.7	1
775	Crash	Los Angeles citizens with vastly separate lives collide in interweaving stories of race, loss and redemption.	112	2004	7.7	2
776	Kung fu	In Shanghai, China in the 1940s, a wannabe gangster aspires to join the notorious "Axe Gang" while residents of a housing complex exhibit extraordinary powers in defending their turf.	99	2004	7.7	2
777	The Bourne Supremacy	When Jason Bourne is framed for a CIA operation gone awry, he is forced to resume his former life as a trained assassin to survive.	108	2004	7.7	1
778	The Machinist	An industrial worker who hasn't slept in a year begins to doubt his own sanity.	101	2004	7.7	5
779	Ray	The story of the life and career of the legendary rhythm and blues musician Ray Charles, from his humble beginnings in the South, where he went blind at age seven, to his meteoric rise to stardom during the 1950s and 1960s.	152	2004	7.7	1
780	Lost in Translation	A faded movie star and a neglected young woman form an unlikely bond after crossing paths in Tokyo.	102	2003	7.7	2
781	Harry Potter and the Goblet of Fire	Harry Potter finds himself competing in a hazardous tournament between rival schools of magic, but he is distracted by recurring nightmares.	157	2005	7.7	2
782	Man on Fire	In Mexico City, a former CIA operative swears vengeance on those who committed an unspeakable act against the family he was hired to protect.	146	2004	7.7	2
783	Coraline	An adventurous 11-year-old girl finds another world that is a strangely idealized version of her frustrating home, but it has sinister secrets.	100	2009	7.7	3
784	The Last Samurai	An American military advisor embraces the Samurai culture he was hired to destroy after he is captured in battle.	154	2003	7.7	2
785	The Magdalene Sisters	Three young Irish women struggle to maintain their spirits while they endure dehumanizing abuse as inmates of a Magdalene Sisters Asylum.	114	2002	7.7	5
786	Good Bye Lenin!	In 1990, to protect his fragile mother from a fatal shock after a long coma, a young man must keep her from learning that her beloved nation of East Germany as she knew it has disappeared.	121	2003	7.7	5
787	In America	A family of Irish immigrants adjust to life on the mean streets of Hell's Kitchen while also grieving the death of a child.	105	2002	7.7	4
788	I Am Sam	A mentally handicapped man fights for custody of his 7-year-old daughter and in the process teaches his cold-hearted lawyer the value of love and family.	132	2001	7.7	4
789	Adaptation.	A lovelorn screenwriter becomes desperate as he tries and fails to adapt 'The Orchid Thief' by Susan Orlean for the screen.	115	2002	7.7	5
790	Black Hawk Down	160 elite U.S. soldiers drop into Somalia to capture two top lieutenants of a renegade warlord and find themselves in a desperate battle with a large force of heavily-armed Somalis.	144	2001	7.7	1
791	Road to Perdition	A mob enforcer's son witnesses a murder, forcing him and his father to take to the road, and his father down a path of redemption and revenge.	117	2002	7.7	1
792	Das Experiment	For two weeks, 20 male participants are hired to play prisoners and guards in a prison. The "prisoners" have to follow seemingly mild rules, and the "guards" are told to retain order without using physical violence.	120	2001	7.7	5
793	Billy Elliot	A talented young boy becomes torn between his unexpected love of dance and the disintegration of his family.	110	2000	7.7	5
794	Hedwig and the Angry Inch	A gender-queer punk-rock singer from East Berlin tours the U.S. with her band as she tells her life story and follows the former lover/band-mate who stole her songs.	95	2001	7.7	5
795	Ocean's Eleven	Danny Ocean and his ten accomplices plan to rob three Las Vegas casinos simultaneously.	116	2001	7.7	2
796	Vampire Hunter D: Bloodlust	When a girl is abducted by a vampire, a legendary bounty hunter is hired to bring her back.	103	2000	7.7	3
797	O Brother, Where Art Thou?	In the deep south during the 1930s, three escaped convicts search for hidden treasure while a relentless lawman pursues them.	107	2000	7.7	3
798	Interstate 60: Episodes of the Road	Neal Oliver, a very confused young man and an artist, takes a journey of a lifetime on a highway I60 that doesn't exist on any of the maps, going to the places he never even heard of, searching for an answer and his dreamgirl.	116	2002	7.7	5
799	South Park: Bigger, Longer & Uncut	When Stan Marsh and his friends go see an R-rated movie, they start cursing and their parents think that Canada is to blame.	81	1999	7.7	1
800	Office Space	Three company workers who hate their jobs decide to rebel against their greedy boss.	89	1999	7.7	5
801	Happiness	The lives of several individuals intertwine as they go about their lives in their own unique ways, engaging in acts society as a whole might find disturbing in a desperate search for human connection.	134	1998	7.7	6
802	Training Day	A rookie cop spends his first day as a Los Angeles narcotics officer with a rogue detective who isn't what he appears to be.	122	2001	7.7	1
803	Rushmore	The extracurricular king of Rushmore Preparatory School is put on academic probation.	93	1998	7.7	2
804	Abre los ojos	A very handsome man finds the love of his life, but he suffers an accident and needs to have his face rebuilt by surgery after it is severely disfigured.	119	1997	7.7	3
805	Being John Malkovich	A puppeteer discovers a portal that leads literally into the head of movie star John Malkovich.	113	1999	7.7	5
806	As Good as It Gets	A single mother and waitress, a misanthropic author, and a gay artist form an unlikely friendship after the artist is assaulted in a robbery.	139	1997	7.7	1
807	The Fifth Element	In the colorful future, a cab driver unwittingly becomes the central figure in the search for a legendary cosmic weapon to keep Evil and Mr. Zorg at bay.	126	1997	7.7	2
808	Le dîner de cons	A few friends have a weekly fools' dinner, where each brings a fool along. Pierre finds a champion fool for next dinner. Surprise.	80	1998	7.7	4
809	Donnie Brasco	An FBI undercover agent infiltrates the mob and finds himself identifying more with the mafia life, at the expense of his regular one.	127	1997	7.7	1
810	Shine	Pianist David Helfgott, driven by his father and teachers, has a breakdown. Years later he returns to the piano, to popular if not critical acclaim.	105	1996	7.7	3
811	Primal Fear	An altar boy is accused of murdering a priest, and the truth is buried several layers deep.	129	1996	7.7	1
812	Hamlet	Hamlet, Prince of Denmark, returns home to find his father murdered and his mother remarrying the murderer, his uncle. Meanwhile, war is brewing.	242	1996	7.7	4
813	A Little Princess	A young girl is relegated to servitude at a boarding school when her father goes missing and is presumed dead.	97	1995	7.7	3
814	Do lok tin si	This Hong Kong-set crime drama follows the lives of a hitman, hoping to get out of the business, and his elusive female partner.	99	1995	7.7	2
815	Il postino	A simple Italian postman learns to love poetry while delivering mail to a famous poet, and then uses this to woo local beauty Beatrice.	108	1994	7.7	3
816	Clerks	A day in the lives of two convenience clerks named Dante and Randal as they annoy customers, discuss movies, and play hockey on the store roof.	92	1994	7.7	5
817	Short Cuts	The day-to-day lives of several suburban Los Angeles residents.	188	1993	7.7	5
818	Philadelphia	When a man with HIV is fired by his law firm because of his condition, he hires a homophobic small time lawyer as the only willing advocate for a wrongful dismissal suit.	125	1993	7.7	2
819	The Muppet Christmas Carol	The Muppet characters tell their version of the classic tale of an old and bitter miser's redemption on Christmas Eve.	85	1992	7.7	8
820	Malcolm X	Biographical epic of the controversial and influential Black Nationalist leader, from his early life and career as a small-time gangster, to his ministry as a member of the Nation of Islam.	202	1992	7.7	3
821	The Last of the Mohicans	Three trappers protect the daughters of a British Colonel in the midst of the French and Indian War.	112	1992	7.7	2
822	Kurenai no buta	In 1930s Italy, a veteran World War I pilot is cursed to look like an anthropomorphic pig.	94	1992	7.7	3
823	Glengarry Glen Ross	An examination of the machinations behind the scenes at a real estate office.	100	1992	7.7	5
824	A Few Good Men	Military lawyer Lieutenant Daniel Kaffee defends Marines accused of murder. They contend they were acting under orders.	138	1992	7.7	3
825	Fried Green Tomatoes	A housewife who is unhappy with her life befriends an old lady in a nursing home and is enthralled by the tales she tells of people she used to know.	130	1991	7.7	4
826	Barton Fink	A renowned New York playwright is enticed to California to write for the movies and discovers the hellish truth of Hollywood.	116	1991	7.7	3
827	Miller's Crossing	Tom Reagan, an advisor to a Prohibition-era crime boss, tries to keep the peace between warring mobs but gets caught in divided loyalties.	115	1990	7.7	5
828	Who Framed Roger Rabbit	A toon-hating detective is a cartoon rabbit's only hope to prove his innocence when he is accused of murder.	104	1988	7.7	3
829	Spoorloos	Rex and Saskia, a young couple in love, are on vacation. They stop at a busy service station and Saskia is abducted. After three years and no sign of Saskia, Rex begins receiving letters from the abductor.	107	1988	7.7	6
830	Withnail & I	In 1969, two substance-abusing, unemployed actors retreat to the countryside for a holiday that proves disastrous.	107	1987	7.7	5
831	The Last Emperor	The story of the final Emperor of China.	163	1987	7.7	3
832	Empire of the Sun	A young English boy struggles to survive under Japanese occupation during World War II.	153	1987	7.7	3
833	Der Name der Rose	An intellectually nonconformist friar investigates a series of mysterious deaths in an isolated abbey.	130	1986	7.7	5
834	Blue Velvet	The discovery of a severed human ear found in a field leads a young man on an investigation related to a beautiful, mysterious nightclub singer and a group of psychopathic criminals who have kidnapped her child.	120	1986	7.7	1
835	The Purple Rose of Cairo	In New Jersey in 1935, a movie character walks off the screen and into the real world.	82	1985	7.7	3
836	After Hours	An ordinary word processor has the worst night of his life after he agrees to visit a girl in Soho who he met that evening at a coffee shop.	97	1985	7.7	2
837	Zelig	"Documentary" about a man who can look and act like whoever he's around, and meets various famous people.	79	1983	7.7	7
838	The Verdict	A lawyer sees the chance to salvage his career and self-respect by taking a medical malpractice case to trial rather than settling.	129	1982	7.7	3
839	Star Trek II: The Wrath of Khan	With the assistance of the Enterprise crew, Admiral Kirk must stop an old nemesis, Khan Noonien Singh, from using the life-generating Genesis Device as the ultimate weapon.	113	1982	7.7	3
840	First Blood	A veteran Green Beret is forced by a cruel Sheriff and his deputies to flee into the mountains and wage an escalating one-man war against his pursuers.	93	1982	7.7	1
841	Ordinary People	The accidental death of the older son of an affluent family deeply strains the relationships among the bitter mother, the good-natured father, and the guilt-ridden younger son.	124	1980	7.7	3
842	Airplane!	A man afraid to fly must ensure that a plane lands safely after the pilots become sick.	88	1980	7.7	3
843	Rupan sansei: Kariosutoro no shiro	A dashing thief, his gang of desperadoes and an intrepid policeman struggle to free a princess from an evil count's clutches, and learn the hidden secret to a fabulous treasure that she holds part of a key to.	100	1979	7.7	3
844	Halloween	Fifteen years after murdering his sister on Halloween night 1963, Michael Myers escapes from a mental hospital and returns to the small town of Haddonfield, Illinois to kill again.	91	1978	7.7	1
845	Le locataire	A bureaucrat rents a Paris apartment where he finds himself drawn into a rabbit hole of dangerous paranoia.	126	1976	7.7	5
846	Love and Death	In czarist Russia, a neurotic soldier and his distant cousin formulate a plot to assassinate Napoleon.	85	1975	7.7	7
847	The Taking of Pelham One Two Three	In New York, armed men hijack a subway car and demand a ransom for the passengers. Even if it's paid, how could they get away?	104	1974	7.7	3
848	Blazing Saddles	In order to ruin a western town, a corrupt politician appoints a black Sheriff, who promptly becomes his most formidable adversary.	93	1974	7.7	1
849	Serpico	An honest New York cop named Frank Serpico blows the whistle on rampant corruption in the force only to have his comrades turn against him.	130	1973	7.7	1
850	Enter the Dragon	A secret agent comes to an opium lord's island fortress with other fighters for a martial-arts tournament.	102	1973	7.7	1
851	Deliverance	Intent on seeing the Cahulawassee River before it's dammed and turned into a lake, outdoor fanatic Lewis Medlock takes his friends on a canoeing trip they'll never forget into the dangerous American back-country.	109	1972	7.7	3
852	The French Connection	A pair of NYC cops in the Narcotics Bureau stumble onto a drug smuggling job with a French connection.	104	1971	7.7	1
853	Dirty Harry	When a madman calling himself "the Scorpio Killer" menaces the city, tough-as-nails San Francisco Police Inspector "Dirty" Harry Callahan is assigned to track down and ferret out the crazed psychopath.	102	1971	7.7	1
854	Where Eagles Dare	Allied agents stage a daring raid on a castle where the Nazis are holding American brigadier general George Carnaby prisoner, but that's not all that's really going on.	158	1968	7.7	3
855	The Odd Couple	Two friends try sharing an apartment, but their ideas of housekeeping and lifestyles are as different as night and day.	105	1968	7.7	8
856	The Dirty Dozen	During World War II, a rebellious U.S. Army Major is assigned a dozen convicted murderers to train and lead them into a mass assassination mission of German officers.	150	1967	7.7	6
857	Belle de jour	A frigid young housewife decides to spend her midweek afternoons as a prostitute.	100	1967	7.7	1
858	A Man for All Seasons	The story of Sir Thomas More, who stood up to King Henry VIII when the King rejected the Roman Catholic Church to obtain a divorce and remarry.	120	1966	7.7	3
859	Repulsion	A sex-repulsed woman who disapproves of her sister's boyfriend sinks into depression and has horrific visions of rape and violence.	105	1965	7.7	6
860	Zulu	Outnumbered British soldiers do battle with Zulu warriors at Rorke's Drift.	138	1964	7.7	3
861	Goldfinger	While investigating a gold magnate's smuggling, James Bond uncovers a plot to contaminate the Fort Knox gold reserve.	110	1964	7.7	1
862	The Birds	A wealthy San Francisco socialite pursues a potential boyfriend to a small Northern California town that slowly takes a turn for the bizarre when birds of all kinds suddenly begin to attack people.	119	1963	7.7	1
863	Cape Fear	A lawyer's family is stalked by a man he once helped put in jail.	106	1962	7.7	9
864	Peeping Tom	A young man murders women, using a movie camera to film their dying expressions of terror.	101	1960	7.7	6
865	The Magnificent Seven	Seven gunfighters are hired by Mexican peasants to liberate their village from oppressive bandits.	128	1960	7.7	15
866	Les yeux sans visage	A surgeon causes an accident which leaves his daughter disfigured, and goes to extremes to give her a new face.	90	1960	7.7	6
867	Invasion of the Body Snatchers	A small-town doctor learns that the population of his community is being replaced by emotionless alien duplicates.	80	1956	7.7	15
868	Rebel Without a Cause	A rebellious young man with a troubled past comes to a new town, finding friends and enemies.	111	1955	7.7	4
869	The Ladykillers	Five oddball criminals planning a bank robbery rent rooms on a cul-de-sac from an octogenarian widow under the pretext that they are classical musicians.	91	1955	7.7	6
870	Sabrina	A playboy becomes interested in the daughter of his family's chauffeur, but it's his more serious brother who would be the better man for her.	113	1954	7.7	9
871	The Quiet Man	A retired American boxer returns to the village of his birth in Ireland, where he falls for a spirited redhead whose brother is contemptuous of their union.	129	1952	7.7	9
872	The Day the Earth Stood Still	An alien lands and tells the people of Earth that they must live peacefully or be destroyed as a danger to other planets.	92	1951	7.7	3
873	The African Queen	In WWI Africa, a gin-swilling riverboat captain is persuaded by a strait-laced missionary to use his boat to attack an enemy warship.	105	1951	7.7	7
874	Gilda	A small-time gambler hired to work in a Buenos Aires casino discovers his employer's new wife is his former lover.	110	1946	7.7	15
875	Fantasia	A collection of animated interpretations of great works of Western classical music.	125	1940	7.7	8
876	The Invisible Man	A scientist finds a way of becoming invisible, but in doing so, he becomes murderously insane.	71	1933	7.7	16
877	Dark Waters	A corporate defense attorney takes on an environmental lawsuit against a chemical company that exposes a lengthy history of pollution.	126	2019	7.6	4
878	Searching	After his teenage daughter goes missing, a desperate father tries to find clues on her laptop.	102	2018	7.6	17
879	Once Upon a Time... in Hollywood	A faded television actor and his stunt double strive to achieve fame and success in the final years of Hollywood's Golden Age in 1969 Los Angeles.	161	2019	7.6	1
880	Nelyubov	A couple going through a divorce must team up to find their son who has disappeared during one of their bitter arguments.	127	2017	7.6	5
881	The Florida Project	Set over one summer, the film follows precocious six-year-old Moonee as she courts mischief and adventure with her ragtag playmates and bonds with her rebellious but caring mother, all while living in the shadows of Walt Disney World.	111	2017	7.6	1
882	Just Mercy	World-renowned civil rights defense attorney Bryan Stevenson works to free a wrongly condemned death row prisoner.	137	2019	7.6	1
883	Gifted	Frank, a single man raising his child prodigy niece Mary, is drawn into a custody battle with his mother.	101	2017	7.6	4
884	The Peanut Butter Falcon	Zak runs away from his care home to make his dream of becoming a wrestler come true.	97	2019	7.6	4
885	Victoria	A young Spanish woman who has recently moved to Berlin finds her flirtation with a local guy turn potentially deadly as their night out with his friends reveals a dangerous secret.	138	2015	7.6	6
886	Mustang	When five orphan girls are seen innocently playing with boys on a beach, their scandalized conservative guardians confine them while forced marriages are arranged.	97	2015	7.6	4
887	Guardians of the Galaxy Vol. 2	The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.	136	2017	7.6	2
888	Baby Driver	After being coerced into working for a crime boss, a young getaway driver finds himself taking part in a heist doomed to fail.	113	2017	7.6	2
889	Only the Brave	Based on the true story of the Granite Mountain Hotshots, a group of elite firefighters who risk everything to protect a town from a historic wildfire.	134	2017	7.6	2
890	Bridge of Spies	During the Cold War, an American lawyer is recruited to defend an arrested Soviet spy in court, and then help the CIA facilitate an exchange of the spy for the Soviet captured American U2 spy plane pilot, Francis Gary Powers.	142	2015	7.6	2
891	Incredibles 2	The Incredibles family takes on a new mission which involves a change in family roles: Bob Parr (Mr. Incredible) must manage the house while his wife Helen (Elastigirl) goes out to save the world.	118	2018	7.6	2
892	Moana	In Ancient Polynesia, when a terrible curse incurred by the Demigod Maui reaches Moana's island, she answers the Ocean's call to seek out the Demigod to set things right.	107	2016	7.6	3
893	Sicario	An idealistic FBI agent is enlisted by a government task force to aid in the escalating war against drugs at the border area between the U.S. and Mexico.	121	2015	7.6	1
894	Creed	The former World Heavyweight Champion Rocky Balboa serves as a trainer and mentor to Adonis Johnson, the son of his late friend and former rival Apollo Creed.	133	2015	7.6	1
895	Leviafan	In a Russian coastal town, Kolya is forced to fight the corrupt mayor when he is told that his house will be demolished. He recruits a lawyer friend to help, but the man's arrival brings further misfortune for Kolya and his family.	140	2014	7.6	5
896	Hell or High Water	A divorced father and his ex-con older brother resort to a desperate scheme in order to save their family's ranch in West Texas.	102	2016	7.6	5
897	Philomena	A world-weary political journalist picks up the story of a woman's search for her son, who was taken away from her decades ago after she became pregnant and was forced to live in a convent.	98	2013	7.6	4
898	Dawn of the Planet of the Apes	A growing nation of genetically evolved apes led by Caesar is threatened by a band of human survivors of the devastating virus unleashed a decade earlier.	130	2014	7.6	2
899	El cuerpo	A detective searches for the body of a femme fatale which has gone missing from a morgue.	112	2012	7.6	6
900	Serbuan maut	A S.W.A.T. team becomes trapped in a tenement run by a ruthless mobster and his army of killers and thugs.	101	2011	7.6	1
901	End of Watch	Shot documentary-style, this film follows the daily grind of two young police officers in LA who are partners and friends, and what happens when they meet criminal forces greater than themselves.	109	2012	7.6	1
902	Kari-gurashi no Arietti	The Clock family are four-inch-tall people who live anonymously in another family's residence, borrowing simple items to make their home. Life changes for the Clocks when their teenage daughter, Arrietty, is discovered.	94	2010	7.6	3
903	A Star Is Born	A musician helps a young singer find fame as age and alcoholism send his own career into a downward spiral.	136	2018	7.6	2
904	True Grit	A stubborn teenager enlists the help of a tough U.S. Marshal to track down her father's murderer.	110	2010	7.6	4
905	Hævnen	The lives of two Danish families cross each other, and an extraordinary but risky friendship comes into bud. But loneliness, frailty and sorrow lie in wait.	118	2010	7.6	5
906	Despicable Me	When a criminal mastermind uses a trio of orphan girls as pawns for a grand scheme, he finds their love is profoundly changing him for the better.	95	2010	7.6	3
907	50/50	Inspired by a true story, a comedy centered on a 27-year-old guy who learns of his cancer diagnosis and his subsequent struggle to beat the disease.	100	2011	7.6	5
908	Kick-Ass	Dave Lizewski is an unnoticed high school student and comic book fan who one day decides to become a superhero, even though he has no powers, training or meaningful reason to do so.	117	2010	7.6	2
909	Celda 211	The story of two men on different sides of a prison riot -- the inmate leading the rebellion and the young guard trapped in the revolt, who poses as a prisoner in a desperate attempt to survive the ordeal.	113	2009	7.6	6
910	Moneyball	Oakland A's general manager Billy Beane's successful attempt to assemble a baseball team on a lean budget by employing computer-generated analysis to acquire new players.	133	2011	7.6	4
911	La piel que habito	A brilliant plastic surgeon, haunted by past tragedies, creates a type of synthetic skin that withstands any kind of damage. His guinea pig: a mysterious and volatile woman who holds the key to his obsession.	120	2011	7.6	5
946	Y tu mamá también	In Mexico, two teenage boys and an attractive older woman embark on a road trip and learn a thing or two about life, friendship, sex, and each other.	106	2001	7.6	1
912	Zombieland	A shy student trying to reach his family in Ohio, a gun-toting tough guy trying to find the last Twinkie, and a pair of sisters trying to get to an amusement park join forces to travel across a zombie-filled America.	88	2009	7.6	1
913	Die Welle	A high school teacher's experiment to demonstrate to his students what life is like under a dictatorship spins horribly out of control when he forms a social unit with a life of its own.	107	2008	7.6	6
914	Sherlock Holmes	Detective Sherlock Holmes and his stalwart partner Watson engage in a battle of wits and brawn with a nemesis whose plot is a threat to all of England.	128	2009	7.6	4
915	The Blind Side	The story of Michael Oher, a homeless and traumatized boy who became an All-American football player and first-round NFL draft pick with the help of a caring woman and her family.	129	2009	7.6	2
916	The Visitor	A college professor travels to New York City to attend a conference and finds a young couple living in his apartment.	104	2007	7.6	4
917	Seven Pounds	A man with a fateful secret embarks on an extraordinary journey of redemption by forever changing the lives of seven strangers.	123	2008	7.6	2
918	Eastern Promises	A teenager who dies during childbirth leaves clues in her journal that could tie her child to a rape involving a violent Russian mob family.	100	2007	7.6	5
919	Stardust	In a countryside town bordering on a magical land, a young man makes a promise to his beloved that he'll retrieve a fallen star by venturing into the magical realm.	127	2007	7.6	3
920	The Secret of Kells	A young boy in a remote medieval outpost under siege from barbarian raids is beckoned to adventure when a celebrated master illuminator arrives with an ancient book, brimming with secret wisdom and powers.	71	2009	7.6	6
921	Inside Man	A police detective, a bank robber, and a high-power broker enter high-stakes negotiations after the criminal's brilliant heist spirals into a hostage situation.	129	2006	7.6	5
922	Gone Baby Gone	Two Boston area detectives investigate a little girl's kidnapping, which ultimately turns into a crisis both professionally and personally.	114	2007	7.6	5
923	La Vie En Rose	Biopic of the iconic French singer Édith Piaf. Raised by her grandmother in a brothel, she was discovered while singing on a street corner at the age of 19. Despite her success, Piaf's life was filled with tragedy.	140	2007	7.6	4
924	Huo Yuan Jia	A biography of Chinese Martial Arts Master Huo Yuanjia, who is the founder and spiritual guru of the Jin Wu Sports Federation.	104	2006	7.6	4
925	The Illusionist	In turn-of-the-century Vienna, a magician uses his abilities to secure the love of a woman far above his social standing.	110	2006	7.6	3
926	Dead Man's Shoes	A disaffected soldier returns to his hometown to get even with the thugs who brutalized his mentally-challenged brother years ago.	90	2004	7.6	6
927	Harry Potter and the Half-Blood Prince	As Harry Potter begins his sixth year at Hogwarts, he discovers an old book marked as "the property of the Half-Blood Prince" and begins to learn more about Lord Voldemort's dark past.	153	2009	7.6	2
928	300	King Leonidas of Sparta and a force of 300 men fight the Persians at Thermopylae in 480 B.C.	117	2006	7.6	1
929	Match Point	At a turning point in his life, a former tennis pro falls for an actress who happens to be dating his friend and soon-to-be brother-in-law.	124	2005	7.6	5
930	Watchmen	In 1985 where former superheroes exist, the murder of a colleague sends active vigilante Rorschach into his own sprawling investigation, uncovering something that could completely change the course of history as we know it.	162	2009	7.6	1
931	Lord of War	An arms dealer confronts the morality of his work as he is being chased by an INTERPOL Agent.	122	2005	7.6	5
932	Saw	Two strangers awaken in a room with no recollection of how they got there, and soon discover they're pawns in a deadly game perpetrated by a notorious serial killer.	103	2004	7.6	2
933	Synecdoche, New York	A theatre director struggles with his work, and the women in his life, as he creates a life-size replica of New York City inside a warehouse as part of his new play.	124	2008	7.6	5
934	Mysterious Skin	A teenage hustler and a young man obsessed with alien abductions cross paths, together discovering a horrible, liberating truth.	105	2004	7.6	5
935	Jeux d'enfants	As adults, best friends Julien and Sophie continue the odd game they started as children -- a fearless competition to outdo one another with daring and outrageous stunts. While they often act out to relieve one another's pain, their game might be a way to avoid the fact that they are truly meant for one another.	93	2003	7.6	5
936	Un long dimanche de fiançailles	Tells the story of a young woman's relentless search for her fiancé, who has disappeared from the trenches of the Somme during World War One.	133	2004	7.6	3
937	The Station Agent	When his only friend dies, a man born with dwarfism moves to rural New Jersey to live a life of solitude, only to meet a chatty hot dog vendor and a woman dealing with her own personal loss.	89	2003	7.6	5
938	21 Grams	A freak accident brings together a critically ill mathematician, a grieving mother, and a born-again ex-con.	124	2003	7.6	2
939	Boksuneun naui geot	A recently laid off factory worker kidnaps his former boss' friend's daughter, hoping to use the ransom money to pay for his sister's kidney transplant.	129	2002	7.6	5
940	Finding Neverland	The story of Sir J.M. Barrie's friendship with a family who inspired him to create Peter Pan.	106	2004	7.6	3
941	25th Hour	Cornered by the DEA, convicted New York drug dealer Montgomery Brogan reevaluates his life in the 24 remaining hours before facing a seven-year jail term.	135	2002	7.6	5
942	The Butterfly Effect	Evan Treborn suffers blackouts during significant events of his life. As he grows up, he finds a way to remember these lost memories and a supernatural way to alter his life by reading his journal.	113	2004	7.6	3
943	28 Days Later...	Four weeks after a mysterious, incurable virus spreads throughout the UK, a handful of survivors try to find sanctuary.	113	2002	7.6	1
944	Batoru rowaiaru	In the future, the Japanese government captures a class of ninth-grade students and forces them to kill each other under the revolutionary "Battle Royale" act.	114	2000	7.6	6
945	The Royal Tenenbaums	The eccentric members of a dysfunctional family reluctantly gather under the same roof for various reasons.	110	2001	7.6	1
947	Harry Potter and the Sorcerer's Stone	An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world.	152	2001	7.6	3
948	The Others	A woman who lives in her darkened old family house with her two photosensitive children becomes convinced that the home is haunted.	101	2001	7.6	4
949	Blow	The story of how George Jung, along with the Medellín Cartel headed by Pablo Escobar, established the American cocaine market in the 1970s in the United States.	124	2001	7.6	5
950	Enemy at the Gates	A Russian and a German sniper play a game of cat-and-mouse during the Battle of Stalingrad.	131	2001	7.6	1
951	Minority Report	In a future where a special police unit is able to arrest murderers before they commit their crimes, an officer from that unit is himself accused of a future murder.	145	2002	7.6	1
952	The Hurricane	The story of Rubin 'Hurricane' Carter, a boxer wrongly imprisoned for murder, and the people who aided in his fight to prove his innocence.	146	1999	7.6	5
953	American Psycho	A wealthy New York City investment banking executive, Patrick Bateman, hides his alternate psychopathic ego from his co-workers and friends as he delves deeper into his violent, hedonistic fantasies.	101	2000	7.6	1
954	Lola rennt	After a botched money delivery, Lola has 20 minutes to come up with 100,000 Deutschmarks.	81	1998	7.6	2
955	The Thin Red Line	Adaptation of James Jones' autobiographical 1962 novel, focusing on the conflict at Guadalcanal during the second World War.	170	1998	7.6	1
956	Mulan	To save her father from death in the army, a young maiden secretly goes in his place and becomes one of China's greatest heroines in the process.	88	1998	7.6	3
957	Fear and Loathing in Las Vegas	An oddball journalist and his psychopathic lawyer travel to Las Vegas for a series of psychedelic escapades.	118	1998	7.6	5
958	Funny Games	Two violent young men take a mother, father, and son hostage in their vacation cabin and force them to play sadistic "games" with one another for their own amusement.	108	1997	7.6	1
959	Dark City	A man struggles with memories of his past, which include a wife he cannot remember and a nightmarish world no one else ever seems to wake up from.	100	1998	7.6	1
960	Sleepers	After a prank goes disastrously wrong, a group of boys are sent to a detention center where they are brutalized. Thirteen years later, an unexpected random encounter with a former guard gives them a chance for revenge.	147	1996	7.6	2
961	Lost Highway	Anonymous videotapes presage a musician's murder conviction, and a gangster's girlfriend leads a mechanic astray.	134	1997	7.6	1
962	Sense and Sensibility	Rich Mr. Dashwood dies, leaving his second wife and her three daughters poor by the rules of inheritance. The two eldest daughters are the title opposites.	136	1995	7.6	3
963	Die Hard: With a Vengeance	John McClane and a Harlem store owner are targeted by German terrorist Simon in New York City, where he plans to rob the Federal Reserve Building.	128	1995	7.6	1
964	Dead Man	On the run after murdering a man, accountant William Blake encounters a strange aboriginal American man named Nobody who prepares him for his journey into the spiritual world.	121	1995	7.6	5
965	The Bridges of Madison County	Photographer Robert Kincaid wanders into the life of housewife Francesca Johnson for four days in the 1960s.	135	1995	7.6	1
966	Apollo 13	NASA must devise a strategy to return Apollo 13 to Earth safely after the spacecraft undergoes massive internal damage putting the lives of the three astronauts on board in jeopardy.	140	1995	7.6	3
967	Trois couleurs: Blanc	After his wife divorces him, a Polish immigrant plots to get even with her.	92	1994	7.6	3
968	Falling Down	An ordinary man frustrated with the various flaws he sees in society begins to psychotically and violently lash out against them.	113	1993	7.6	5
969	Dazed and Confused	The adventures of high school and junior high students on the last day of school in May 1976.	102	1993	7.6	3
970	My Cousin Vinny	Two New Yorkers accused of murder in rural Alabama while on their way back to college call in the help of one of their cousins, a loudmouth lawyer with no trial experience.	120	1992	7.6	2
971	Omohide poro poro	A twenty-seven-year-old office worker travels to the countryside while reminiscing about her childhood in Tokyo.	118	1991	7.6	3
972	Delicatessen	Post-apocalyptic surrealist black comedy about the landlord of an apartment building who occasionally prepares a delicacy for his odd tenants.	99	1991	7.6	5
973	Home Alone	An eight-year-old troublemaker must protect his house from a pair of burglars when he is accidentally left home alone by his family during Christmas vacation.	103	1990	7.6	3
974	The Godfather: Part III	Follows Michael Corleone, now in his 60s, as he seeks to free his family from crime and find a suitable successor to his empire.	162	1990	7.6	1
975	When Harry Met Sally...	Harry and Sally have known each other for years, and are very good friends, but they fear sex would ruin the friendship.	95	1989	7.6	2
976	The Little Mermaid	A mermaid princess makes a Faustian bargain in an attempt to become human and win a prince's love.	83	1989	7.6	3
977	The Naked Gun: From the Files of Police Squad!	Incompetent police Detective Frank Drebin must foil an attempt to assassinate Queen Elizabeth II.	85	1988	7.6	3
978	Planes, Trains & Automobiles	A man must struggle to travel home for Thanksgiving with a lovable oaf of a shower curtain ring salesman as his only companion.	93	1987	7.6	3
979	Lethal Weapon	Two newly paired cops who are complete opposites must put aside their differences in order to catch a gang of drug smugglers.	109	1987	7.6	1
980	Blood Simple	The owner of a seedy small-town Texas bar discovers that one of his employees is having an affair with his wife. A chaotic chain of misunderstandings, lies and mischief ensues after he devises a plot to have them murdered.	99	1984	7.6	1
981	On Golden Pond	Norman is a curmudgeon with an estranged relationship with his daughter Chelsea. At Golden Pond, he and his wife nevertheless agree to care for Billy, the son of Chelsea's new boyfriend, and a most unexpected relationship blooms.	109	1981	7.6	2
982	Mad Max 2	In the post-apocalyptic Australian wasteland, a cynical drifter agrees to help a small, gasoline-rich community escape a horde of bandits.	96	1981	7.6	1
983	The Warriors	In the near future, a charismatic leader summons the street gangs of New York City in a bid to take it over. When he is killed, The Warriors are falsely blamed and now must fight their way home while every other gang is hunting them down.	92	1979	7.6	2
984	The Muppet Movie	Kermit and his newfound friends trek across America to find success in Hollywood, but a frog legs merchant is after Kermit.	95	1979	7.6	3
985	Escape from Alcatraz	Alcatraz is the most secure prison of its time. It is believed that no one can ever escape from it, until three daring men make a possible successful attempt at escaping from one of the most infamous prisons in the world.	112	1979	7.6	1
986	Watership Down	Hoping to escape destruction by human developers and save their community, a colony of rabbits, led by Hazel and Fiver, seek out a safe place to set up a new warren.	91	1978	7.6	3
987	Midnight Express	Billy Hayes, an American college student, is caught smuggling drugs out of Turkey and thrown into prison.	121	1978	7.6	1
988	Close Encounters of the Third Kind	Roy Neary, an electric lineman, watches how his quiet and ordinary daily life turns upside down after a close encounter with a UFO.	138	1977	7.6	3
989	The Long Goodbye	Private investigator Philip Marlowe helps a friend out of a jam, but in doing so gets implicated in his wife's murder.	112	1973	7.6	1
990	Giù la testa	A low-life bandit and an I.R.A. explosives expert rebel against the government and become heroes of the Mexican Revolution.	157	1971	7.6	7
991	Kelly's Heroes	A group of U.S. soldiers sneaks across enemy lines to get their hands on a secret stash of Nazi treasure.	144	1970	7.6	14
992	The Jungle Book	Bagheera the Panther and Baloo the Bear have a difficult time trying to convince a boy to leave the jungle for human civilization.	78	1967	7.6	3
993	Blowup	A fashion photographer unknowingly captures a death on film after following two lovers in a park.	111	1966	7.6	1
994	A Hard Day's Night	Over two "typical" days in the life of The Beatles, the boys struggle to keep themselves and Sir Paul McCartney's mischievous grandfather in check while preparing for a live television performance.	87	1964	7.6	3
995	Breakfast at Tiffany's	A young New York socialite becomes interested in a young man who has moved into her apartment building, but her past threatens to get in the way.	115	1961	7.6	1
996	Giant	Sprawling epic covering the life of a Texas cattle rancher and his family and associates.	201	1956	7.6	8
997	From Here to Eternity	In Hawaii in 1941, a private is cruelly punished for not boxing on his unit's team, while his captain's wife and second-in-command are falling in love.	118	1953	7.6	9
998	Lifeboat	Several survivors of a torpedoed merchant ship in World War II find themselves in the same lifeboat with one of the crew members of the U-boat that sank their ship.	97	1944	7.6	6
999	The 39 Steps	A man in London tries to help a counter-espionage Agent. But when the Agent is killed, and the man stands accused, he must go on the run to save himself and stop a spy ring which is trying to steal top secret information.	86	1935	7.6	6
\.


--
-- Data for Name: tbl_ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_ratings (id, description) FROM stdin;
1	A
2	UA
3	U
4	PG-13
5	R
6	Not Rated
7	PG
8	G
9	Passed
10	TV-14
11	16
12	TV-MA
13	Unrated
14	GP
15	Approved
16	TV-PG
17	U/A
\.


--
-- Data for Name: tbl_recommendations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_recommendations (user_id, movie_id, recommendation_score) FROM stdin;
1	65	80
2	64	0
1	64	93.33
\.


--
-- Data for Name: tbl_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_users (id, name, favorite_actor_id, favorite_director_id, favorite_gender_id, created_at) FROM stdin;
1	Guilherme	5	3	3	2026-06-17 20:17:51.909841
2	João	2	1	20	2026-06-17 22:07:02.530752
\.


--
-- Name: tbl_actors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_actors_id_seq', 1319, true);


--
-- Name: tbl_directors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_directors_id_seq', 547, true);


--
-- Name: tbl_genders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_genders_id_seq', 21, true);


--
-- Name: tbl_movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_movies_id_seq', 999, true);


--
-- Name: tbl_ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_ratings_id_seq', 17, true);


--
-- Name: tbl_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_users_id_seq', 2, true);


--
-- Name: tbl_actors tbl_actors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_actors
    ADD CONSTRAINT tbl_actors_pkey PRIMARY KEY (id);


--
-- Name: tbl_directors tbl_directors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_directors
    ADD CONSTRAINT tbl_directors_pkey PRIMARY KEY (id);


--
-- Name: tbl_genders tbl_genders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_genders
    ADD CONSTRAINT tbl_genders_pkey PRIMARY KEY (id);


--
-- Name: tbl_historic tbl_historic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_historic
    ADD CONSTRAINT tbl_historic_pkey PRIMARY KEY (user_id, movie_id);


--
-- Name: tbl_movie_actor tbl_movie_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_actor
    ADD CONSTRAINT tbl_movie_actor_pkey PRIMARY KEY (movie_id, actor_id);


--
-- Name: tbl_movie_director tbl_movie_director_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_director
    ADD CONSTRAINT tbl_movie_director_pkey PRIMARY KEY (movie_id, director_id);


--
-- Name: tbl_movie_gender tbl_movie_gender_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_gender
    ADD CONSTRAINT tbl_movie_gender_pkey PRIMARY KEY (movie_id, gender_id);


--
-- Name: tbl_movies tbl_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movies
    ADD CONSTRAINT tbl_movies_pkey PRIMARY KEY (id);


--
-- Name: tbl_ratings tbl_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_ratings
    ADD CONSTRAINT tbl_ratings_pkey PRIMARY KEY (id);


--
-- Name: tbl_recommendations tbl_recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_recommendations
    ADD CONSTRAINT tbl_recommendations_pkey PRIMARY KEY (user_id, movie_id);


--
-- Name: tbl_users tbl_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT tbl_users_pkey PRIMARY KEY (id);


--
-- Name: idx_historic_liked; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_historic_liked ON public.tbl_historic USING btree (liked);


--
-- Name: idx_historic_movie_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_historic_movie_id ON public.tbl_historic USING btree (movie_id);


--
-- Name: idx_movie_actor_actor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movie_actor_actor_id ON public.tbl_movie_actor USING btree (actor_id);


--
-- Name: idx_movie_director_director_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movie_director_director_id ON public.tbl_movie_director USING btree (director_id);


--
-- Name: idx_movie_gender_gender_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movie_gender_gender_id ON public.tbl_movie_gender USING btree (gender_id);


--
-- Name: idx_movies_rating_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movies_rating_id ON public.tbl_movies USING btree (rating_id);


--
-- Name: idx_recommendations_movie_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recommendations_movie_id ON public.tbl_recommendations USING btree (movie_id);


--
-- Name: tbl_historic fk_historic_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_historic
    ADD CONSTRAINT fk_historic_movie FOREIGN KEY (movie_id) REFERENCES public.tbl_movies(id) ON DELETE CASCADE;


--
-- Name: tbl_historic fk_historic_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_historic
    ADD CONSTRAINT fk_historic_user FOREIGN KEY (user_id) REFERENCES public.tbl_users(id) ON DELETE CASCADE;


--
-- Name: tbl_movie_actor fk_movie_actor_actor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_actor
    ADD CONSTRAINT fk_movie_actor_actor FOREIGN KEY (actor_id) REFERENCES public.tbl_actors(id);


--
-- Name: tbl_movie_actor fk_movie_actor_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_actor
    ADD CONSTRAINT fk_movie_actor_movie FOREIGN KEY (movie_id) REFERENCES public.tbl_movies(id) ON DELETE CASCADE;


--
-- Name: tbl_movie_director fk_movie_director_director; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_director
    ADD CONSTRAINT fk_movie_director_director FOREIGN KEY (director_id) REFERENCES public.tbl_directors(id);


--
-- Name: tbl_movie_director fk_movie_director_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_director
    ADD CONSTRAINT fk_movie_director_movie FOREIGN KEY (movie_id) REFERENCES public.tbl_movies(id) ON DELETE CASCADE;


--
-- Name: tbl_movie_gender fk_movie_gender_gender; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_gender
    ADD CONSTRAINT fk_movie_gender_gender FOREIGN KEY (gender_id) REFERENCES public.tbl_genders(id);


--
-- Name: tbl_movie_gender fk_movie_gender_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movie_gender
    ADD CONSTRAINT fk_movie_gender_movie FOREIGN KEY (movie_id) REFERENCES public.tbl_movies(id) ON DELETE CASCADE;


--
-- Name: tbl_movies fk_movies_rating; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_movies
    ADD CONSTRAINT fk_movies_rating FOREIGN KEY (rating_id) REFERENCES public.tbl_ratings(id);


--
-- Name: tbl_recommendations fk_recommendations_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_recommendations
    ADD CONSTRAINT fk_recommendations_movie FOREIGN KEY (movie_id) REFERENCES public.tbl_movies(id) ON DELETE CASCADE;


--
-- Name: tbl_recommendations fk_recommendations_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_recommendations
    ADD CONSTRAINT fk_recommendations_user FOREIGN KEY (user_id) REFERENCES public.tbl_users(id) ON DELETE CASCADE;


--
-- Name: tbl_users fk_users_actor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT fk_users_actor FOREIGN KEY (favorite_actor_id) REFERENCES public.tbl_actors(id);


--
-- Name: tbl_users fk_users_director; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT fk_users_director FOREIGN KEY (favorite_director_id) REFERENCES public.tbl_directors(id);


--
-- Name: tbl_users fk_users_gender; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT fk_users_gender FOREIGN KEY (favorite_gender_id) REFERENCES public.tbl_genders(id);


--
-- PostgreSQL database dump complete
--

\unrestrict DghNUhACGMQgmgdOxfuHngdQzz4efxg3apmJpt8zBBUTOLfkun1JlwF2Q8yaqZp

