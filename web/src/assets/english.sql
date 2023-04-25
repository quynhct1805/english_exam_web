PGDMP         1                {            english_exam_db    13.10    13.9 J    +           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ,           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            -           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            .           1262    16527    english_exam_db    DATABASE     c   CREATE DATABASE english_exam_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE english_exam_db;
                postgres    false            /           0    0    english_exam_db    DATABASE PROPERTIES     E   ALTER DATABASE english_exam_db SET "TimeZone" TO 'Asia/Ho_Chi_Minh';
                     postgres    false            �           1247    57488    skill    TYPE     d   CREATE TYPE public.skill AS ENUM (
    'Listening',
    'Reading',
    'Speaking',
    'Writing'
);
    DROP TYPE public.skill;
       public          postgres    false            �            1259    16547 
   categories    TABLE     �   CREATE TABLE public.categories (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    code text NOT NULL
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    16545    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    203            0           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    202            �            1259    16657    documentations    TABLE     �   CREATE TABLE public.documentations (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    category_id integer,
    created_at date,
    skill public.skill,
    files jsonb,
    doc text,
    type text
);
 "   DROP TABLE public.documentations;
       public         heap    postgres    false    677            �            1259    16655    documentations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.documentations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.documentations_id_seq;
       public          postgres    false    213            1           0    0    documentations_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.documentations_id_seq OWNED BY public.documentations.id;
          public          postgres    false    212            �            1259    16585 	   histories    TABLE     �   CREATE TABLE public.histories (
    id integer NOT NULL,
    user_id integer,
    test_id integer,
    grade text,
    "time" integer,
    created_at timestamp without time zone,
    answers text[]
);
    DROP TABLE public.histories;
       public         heap    postgres    false            �            1259    16583    histories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.histories_id_seq;
       public          postgres    false    207            2           0    0    histories_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.histories_id_seq OWNED BY public.histories.id;
          public          postgres    false    206            �            1259    16619    parts    TABLE     �   CREATE TABLE public.parts (
    id integer NOT NULL,
    name text,
    total_ques integer,
    description text,
    test_id integer,
    audio text,
    paragraph text
);
    DROP TABLE public.parts;
       public         heap    postgres    false            �            1259    16617    parts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.parts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.parts_id_seq;
       public          postgres    false    209            3           0    0    parts_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.parts_id_seq OWNED BY public.parts.id;
          public          postgres    false    208            �            1259    49303 	   questions    TABLE     �   CREATE TABLE public.questions (
    id integer NOT NULL,
    name text,
    part_id integer,
    question text,
    true_answer text,
    explaination text,
    answers text[]
);
    DROP TABLE public.questions;
       public         heap    postgres    false            �            1259    49301    questions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.questions_id_seq;
       public          postgres    false    215            4           0    0    questions_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;
          public          postgres    false    214            �            1259    16635    reviews    TABLE       CREATE TABLE public.reviews (
    id integer NOT NULL,
    user_id integer,
    test_id integer,
    rate_stars integer,
    comment text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_DATE,
    updated_at timestamp without time zone
);
    DROP TABLE public.reviews;
       public         heap    postgres    false            �            1259    16633    reviews_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.reviews_id_seq;
       public          postgres    false    211            5           0    0    reviews_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;
          public          postgres    false    210            �            1259    16569    tests    TABLE     �   CREATE TABLE public.tests (
    id integer NOT NULL,
    name text NOT NULL,
    category_id integer,
    total_part integer,
    description text,
    "time" integer,
    total_ques integer,
    skill public.skill
);
    DROP TABLE public.tests;
       public         heap    postgres    false    677            �            1259    16567    tests_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.tests_id_seq;
       public          postgres    false    205            6           0    0    tests_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.tests_id_seq OWNED BY public.tests.id;
          public          postgres    false    204            �            1259    16530    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    phone text,
    email text NOT NULL,
    password text,
    role text,
    code text
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16528    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    201            7           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    200            o           2604    16550    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            u           2604    16660    documentations id    DEFAULT     v   ALTER TABLE ONLY public.documentations ALTER COLUMN id SET DEFAULT nextval('public.documentations_id_seq'::regclass);
 @   ALTER TABLE public.documentations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213            q           2604    16588    histories id    DEFAULT     l   ALTER TABLE ONLY public.histories ALTER COLUMN id SET DEFAULT nextval('public.histories_id_seq'::regclass);
 ;   ALTER TABLE public.histories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207            r           2604    16622    parts id    DEFAULT     d   ALTER TABLE ONLY public.parts ALTER COLUMN id SET DEFAULT nextval('public.parts_id_seq'::regclass);
 7   ALTER TABLE public.parts ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            v           2604    49306    questions id    DEFAULT     l   ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);
 ;   ALTER TABLE public.questions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            s           2604    16638 
   reviews id    DEFAULT     h   ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);
 9   ALTER TABLE public.reviews ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            p           2604    16572    tests id    DEFAULT     d   ALTER TABLE ONLY public.tests ALTER COLUMN id SET DEFAULT nextval('public.tests_id_seq'::regclass);
 7   ALTER TABLE public.tests ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    205    205            n           2604    16533    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    200    201    201                      0    16547 
   categories 
   TABLE DATA           A   COPY public.categories (id, name, description, code) FROM stdin;
    public          postgres    false    203   pS       &          0    16657    documentations 
   TABLE DATA           q   COPY public.documentations (id, name, description, category_id, created_at, skill, files, doc, type) FROM stdin;
    public          postgres    false    213   iT                  0    16585 	   histories 
   TABLE DATA           ]   COPY public.histories (id, user_id, test_id, grade, "time", created_at, answers) FROM stdin;
    public          postgres    false    207   �a       "          0    16619    parts 
   TABLE DATA           ]   COPY public.parts (id, name, total_ques, description, test_id, audio, paragraph) FROM stdin;
    public          postgres    false    209   �b       (          0    49303 	   questions 
   TABLE DATA           d   COPY public.questions (id, name, part_id, question, true_answer, explaination, answers) FROM stdin;
    public          postgres    false    215   v       $          0    16635    reviews 
   TABLE DATA           d   COPY public.reviews (id, user_id, test_id, rate_stars, comment, created_at, updated_at) FROM stdin;
    public          postgres    false    211   G�                 0    16569    tests 
   TABLE DATA           j   COPY public.tests (id, name, category_id, total_part, description, "time", total_ques, skill) FROM stdin;
    public          postgres    false    205   Ŧ                 0    16530    users 
   TABLE DATA           M   COPY public.users (id, name, phone, email, password, role, code) FROM stdin;
    public          postgres    false    201   M�       8           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 55, true);
          public          postgres    false    202            9           0    0    documentations_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.documentations_id_seq', 71, true);
          public          postgres    false    212            :           0    0    histories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.histories_id_seq', 20, true);
          public          postgres    false    206            ;           0    0    parts_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.parts_id_seq', 12, true);
          public          postgres    false    208            <           0    0    questions_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.questions_id_seq', 146, true);
          public          postgres    false    214            =           0    0    reviews_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.reviews_id_seq', 14, true);
          public          postgres    false    210            >           0    0    tests_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.tests_id_seq', 15, true);
          public          postgres    false    204            ?           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 25, true);
          public          postgres    false    200            ~           2606    57500    categories categories_coded_key 
   CONSTRAINT     Z   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_coded_key UNIQUE (code);
 I   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_coded_key;
       public            postgres    false    203            �           2606    16557    categories categories_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_name_key;
       public            postgres    false    203            �           2606    16555    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    203            �           2606    16665 "   documentations documentations_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.documentations
    ADD CONSTRAINT documentations_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.documentations DROP CONSTRAINT documentations_pkey;
       public            postgres    false    213            �           2606    16590    histories histories_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.histories
    ADD CONSTRAINT histories_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.histories DROP CONSTRAINT histories_pkey;
       public            postgres    false    207            �           2606    16627    parts parts_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.parts DROP CONSTRAINT parts_pkey;
       public            postgres    false    209            �           2606    49311    questions questions_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_pkey;
       public            postgres    false    215            �           2606    16644    reviews reviews_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public            postgres    false    211            �           2606    16577    tests tests_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tests DROP CONSTRAINT tests_pkey;
       public            postgres    false    205            x           2606    16544    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    201            z           2606    16540    users users_name_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT users_name_key;
       public            postgres    false    201            |           2606    16538    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    201            �           2606    16666 .   documentations documentations_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.documentations
    ADD CONSTRAINT documentations_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);
 X   ALTER TABLE ONLY public.documentations DROP CONSTRAINT documentations_category_id_fkey;
       public          postgres    false    2946    213    203            �           2606    16596     histories histories_test_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.histories
    ADD CONSTRAINT histories_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id);
 J   ALTER TABLE ONLY public.histories DROP CONSTRAINT histories_test_id_fkey;
       public          postgres    false    205    2948    207            �           2606    16591     histories histories_user_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.histories
    ADD CONSTRAINT histories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 J   ALTER TABLE ONLY public.histories DROP CONSTRAINT histories_user_id_fkey;
       public          postgres    false    207    2940    201            �           2606    49317    parts parts_test_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id);
 B   ALTER TABLE ONLY public.parts DROP CONSTRAINT parts_test_id_fkey;
       public          postgres    false    209    205    2948            �           2606    49312     questions questions_part_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(id);
 J   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_part_id_fkey;
       public          postgres    false    2952    209    215            �           2606    16650    reviews reviews_test_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id);
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_test_id_fkey;
       public          postgres    false    2948    205    211            �           2606    16645    reviews reviews_user_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_user_id_fkey;
       public          postgres    false    2940    201    211            �           2606    16578    tests tests_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);
 F   ALTER TABLE ONLY public.tests DROP CONSTRAINT tests_category_id_fkey;
       public          postgres    false    203    205    2946               �   x�m�AN1E��)| :���+Xvcf<�Ռ]%�V��I�:�*������{�*FI�X#<K�����f���%�ǒ�&�(�$^$V$0j�l����!5����C瘢e��*t\u�:��N�,ܷw��q6����4������IG_���l*�D���J�s�L���d�/����wp�yN��n���#�R)�X����M�$i����i�:-�OE���������� ���      &   h  x��Y[��~��z	��d؝�V���⋰�vc<~�鮙�lwU��zg����`bL��V�_�,��x���_����F8���T��w�:uNi�BKl�{�$*�^���-ޭ��f(N��j������֕�=-|��lzv����Ƀ��f�?{����u6����������ɏ�<����1�MJџ�A-���ɇ��z�U-�l�H�fӃ�n���b8�����3=#�׳�შ�ܐ��"�އ��V���s-�l����b)�f��4��a��
7;|\�}�V��O�S\�1�wN�t6������E������d�	�:�'�~Ln�q7m�8B���/=�Zo��hEP[����� ��ʨJ�b����)�����}e�}s��z6�H��S�^��K��v��_�ĳO ��SV����aݘ�Q!o>{��
�If㲟~��z6��H�����' ��.v�;� Y{ٚϦ_��{(@�"�?$`�ۦ� T���&$�sy)��
��zv����1e�D;R	 oX���>��X�$��{��D7�eQ�
����G8� o��3��p���T�R�TȾ��讉B��+'��c�8C��$r��� ��-�Sb�\�eh�Y���]�LHc}�*�|�*�I�kv��T���m-�����\.�aY!̡* 	M)+h|оg�c�:�s�ۊ���O�)�\y�X�)!���M%!!,�aQz^�At�5�߃h�~�u_��%��+^r�׬#.��2�ɹj�;���T �cnFY�T�2��KQ��')�g���@U���~%����H_���V���0
��l��W�i��S��6G��``G̑�+Y�m]	[�2�E��6P(��D͇�$��)�~��%d�� $�8=#!K TVZz��Q�o]�F�R�B���JP���UbP��;��g*�A�+���@��!oDն�U �.�.�V����;���A
"uENL>�����K�����=�AI�����cW�nb�W���e]�Q���x��j���L���W��L,�N��:��Pc��!���UK'
W%�oj�%��X�8�ۣ���Qk��I� ��o�x^ �r�.q*��3�J�)�$�k�����VS�-t
��b��8Ե�Ӷ��횳J�;� ���C�<;�	�@�:�HWu�!H�,��P�6a!���=T'N�Yf����'Ҩ��ʵ�t[�#��d�LH�s�15
��.Q2���E�5����҉��#�L(H�8�$x�������j����o���w.���=��~��"��<� /PIF�p(�q����`=�H'@U(u��D�*�t_�̫�,(��-�A���_�7'/����gh��/��:1\�TE\Pwp����>Ī`s�R5艣�w���m>܌\�/�X���[�����ÔT�5GUsm�qH?	Ht{H>�.J�n�]��������<4S��}E��gb���겴E�P;��ڌd$7�2��i%GF`�H G�J.7d�Tt� 8QԠy��[���W���g�pY�����j78�U��Q9����>��������m:71D0w�YT�>�8�&�� |��7��
�(Qr\�S5
7+!S�s���#��ۧ&��pf��[�tljd�|�m���U�/�OaO��Q��ITs�� [�kǗ"H ���6P���֌��:#W\q���;|V���Νo����O�P����������)u�����:w���l�q�r^L���c�y��lz��*�C�Z�r�h�T\�6Z�kk+#	����L�t�a�im��9�dva�!f t���^xE��<�![6L>IV��6���~[����m�|FX_[[��z����� �_ݎr&�@C0�^������v�P{a�70;��EZ�>L)w1JN�jvs6��`(�S�SI#�Ǵ�Ac��l�T����E��!�ϋ����3b�(��f�{���"^ˠ�&�p ���0�-'�#ޮ1����8dg���'<K-#4a��X�`�B@��;��	�}ĺx�s�E�?*EJ� ���Ph'h`&B�� +���ta/�ES	����
���|z���'�{���=�H�0 �O�[�r��� >?�| ����w�w���(�ֿ�+`zX�dH����3�Q0���0�� �v�X����O��̌��gm�X�[B�擋pi��t0�	Sf�@�.�q�5��(wW3��|F� �8� 1>����v���r���B��ST���p�Q� )؎����n��Ls8I%�>�n�����"M�����II�O�yǢ�g�#Z����ޟ��~kq��6G�(Nߘ�|�r�ި�>]��Zb���qy�vt�~����au'�G�s��F�g��g.���ۙ,�S}�3��-���;��d�3�U!SP��'�	�XQ�&)�"�N ��>�Z�|M�DP~���<Ӿ|��ߊr�|�	|�����vaa�G�����c+:w��߰a�<Y�+����sh���,�<�����v��v=F}ɞ}nČ�T�/X�cn��6ԡ�ث���l�L�<��/��N��f#��
�	y,c�3Cb������;T���}��u8K3Yޡ��<̅�'b�ɳ��a�G�Ӡ
c�$�BA�H�&[�w �Ç`wM�C����e.ќ����aN��7���$�Ɔz���Û�j�.�J�jX��M$X�_\�9K�G��e���U3J*��D���U�0EC˨`�Mv��*0�D�,�(�|p�������������W�`��v$j[����vjq��+d����,��n�b&���g�Zz�Z7W��m6bLȫ9E��{ ���]3æ�ݐ���F���2zv;�"q:^�t�7{�S�(��@wamJ5���;��^���k���Mc�#��A�uN	��mP?��F�YtŦc	\�;�5�
7Eq�F�' ���
��S���]�ަ3��bB\��P�0��˚v�O47L���[Q�ĵϽB�#\P�'����A��r{!��F�l�J2��p8���{n�x��	~E�
c��C۸�:MOmG
�х�A��<</gtu�K��5�s����ڷ��QA��b�ԅUc4t�cRTs�^\�k���J$���is^Ϯ�HiLՉ?A����?.ڀ����ޠ����6�Z��yns��^����^G�������:o�8:��ć<�Z��K^��e���es�-=X���٪���:�(D��5_��J̯������4�cz��Wv���_*� �0rO�o^��w��y�����ͣSRW�6�/s��RE�l�^<y;t&��^*`_RU��;?�!���3M|����̾�p]����g[g�/�N�s�ԩ���          �   x�]�K�0��>@�� ����M�ܽD�R�B���	$��2� aѕme��u2�p:�Ȣ���1�ؙ0��	[er����ɽ4umJ�������P�o�h�֧����3	Gd��іE��J����~���(�,�      "      x��Z��Gr=��NI�A�$��N�+i-�
��#x)t��twa���N�������/�{�UՍ�������2_�|��/��6�����U��Wϯnn��L��m����է�m�����y������o���ʫ'~|}����������gZw�p��0��3#��!m�4�.�c��&Zߝ����i�~��v>��l�+�m^�ܤU�����'�c8N�=�Gw2v4v06�a�� ���V���mglt�l]c{g��௄���i°wit���۶����f��h��ge{��C����S�w&�4uX��>D'ȇ�M��!1����i��7��Gۭ�w���ؼz�0����}�ѺƷ��®y{�!�tSך!�أ�]��p]0ؽ�r�[?�Wˇ�;���k����RR���a0u_�d���'ܐF	J2�{<����������G���O��!D�d;�n\�S�N�r�>ՠ�΍ɜܻ���7BL��F���fm�Ɛ�jA��5����r�ߏ������(O�
GxK�敹���|�a�{�%҇k���;lqi�w��cǐ4.�j���J�˶s=���F����4�a�k�Ǜ M��>��}h����N�S��$��,R&;�>Eb��`c�;r6&��t�@f�.�p���}p�.�"�d�a<����"��!��'��{;��K"��V �$(�N��w�gc�;\�aj:l��LƊ�+1أ���<i	=b�1��}r���G�����d�~\�n� ]���4N����)�O����@أ젠(���U����%7ښ��"'���@�6C!�$,�V�)��bc��i��q�L<vV0��%-���~q�]��P�P��w
d�]=���Q1wK8c�r�2b�*��U.TP�	@��Z2Ș=�%��m:w����H;:��`�g �A�g��ʹ��l��L��i���s�k��i����<5��Yb}�,�ŷ?���`�P���c؏�|R;Z�n�\�'Ű'H?��k8��١��m'��,�[	qoQ��A��j&3(Y��+���~f`��_��oJ^~>:p-HGYi%���F!�)U{��"(�E�O�8�n�i{�l���}K�)l�iY��	H�RN�&t�=b}�\pr�_y`�'&;E��TQnGIK0��|QN�����5�}.��4���p#3fQps��Ҩ��zg��G�#���AGn�P2捂5j����g<v5��4����5�K���ߋ)0��_o_ܬnnn
i���_�L��e��!��g� �n��_7�&9@B}#�q@	n�4R?��� � l����l+)���Ù��!@H`1҇.K�0@"�}��m�N�V��sY"�nPɆ�&)��[��!�. q7�*��`0�L�dh�, n��$b�����29s7�E�����n�QK���^�7��?[x	�AЁ�X���8���ֹ��N�Yv&\	���m��7� m
�� m���=v���躬�°�,�n�t��`#l��=�d�ڑ�F�O�r
�b���3���jě;롽H[��x���X�/�)��5#.�yI�@q��������g��^e%Ʉ�]+l���	>���rEk���5/�d@ω#@�;8q����L�
�_��w���H�7��z�C��dh�s�[^X/��K��h��x�~������JB�[Z��։��&��[�_.8�H��膔u�|�Dl�le!Q��_g��?J�e({}�94�V�m$��V���2Qş8�;ۣh����W�@_�n)\��#�z%㤹 ³��}a
�Ќ�V� =�� -C��Vr���ffx��@�'���N��x��]�N�(���Q�"���~O�.,��T�Ub��Jse�P���iJeB���vQrR�Gv���zy�h��qDB8��d�sӋB�+�O��E�H��%�x��3T��՜g�R77�^���=��4,[��x)�j�!�y6^��2ڝ�:Y��CV_t�����G���}�<��b�Ux��F�a����]��O�?Y�$�/J��E%!��d�U7�v^2` WwԎ�(*I��U�x�m��r�(�U�����vy�W�UևGI��'�qX�e!��Ӯ�hW�(CL�&�1�e��Eָ��S<,�U�{g�Ӫ膴sB��f��,����3�?����f�<�tֵV���ݪ���| 2RV��?r �5,��<I���F7@1T͔�`�14w'�up���#�ޓX>�~�u�11����r1�J�����ٍ�����T4Z�ZIBӈ@E�!���l񔖚GK5Yļ/S"jT�>��	m:7�Q_�^�x&�\ �j�y�A*c_lsأ�Z:
v���ޟ�a��D�p�G�D�I{�ZP�+n��~/c��������x�c��Ǭfe8*?|��n��?N[@�V�\���`.ҰJT�圇�:�H�d�=�����
u�WINk�c�g�$q`VA�Z���z�_�6������tg(W�3�� �g���^�S��~SF7\��ݙ(���7>rN�待A��� �u��S-�)ܿ�Հ�~X�i��+�ޝ�-��ٲ%��/"�1���''��M�"?e�j�|\@I{�( D�F�ߵy&z~�M1��J��;!�U�iU�_��b��֎V&���kQ������T�H�qȝ�Y`-ٟ����x�V/�+�bϑ�=��IRG F&9�xX?�+����_���S�	��Q�]�%f/��>�8y�� ,��Rq�j7���\�W��n^޼����_��t'��n�$m����>��O�#�$��?��JW�w�=��Ms��w(Rb�ߘ�S!*��]��0�|ˮ�ˮU�q�TP2�;�wK?2Kx� ݝxuUXv3)��p|�l#��͆�b$��R���NZ£d��	�<��)/hh���<�T ��Щ�&ȵ�^����L��6{=İfgS�)o�Wɡ�Y�Z�=@������(�2�9X�"��_k/�*�e�!�G�Y
=��J����t���({�e2��!���3���}.�X�=1	~�S�����Ь*θ�ġr��xa q&,��%a/����{`���	��2�3�-M�� ���)����x�.ؿ���>�F��tHe�@�%t�d��5:)�.�M�5o���:���Ñ�? p�7��������k���˕fi��څF�e.���;�,�=GF��z�*���%
n�Y���1b�<Hq#�Q��.���F�1�P6$*�(t^I�<�N.�.�x���'h|���Q��	�j#P���L��3	�H=y伈S_�a}���N
�@\���<�M"�\o���ő�f�u�!ļ(D$;�aqg�B1�X�sI*韒�k��������lD�b8�a������w��m��/v����Rb�Z��W_����{�>S'�NU{�Ew8
�&��-��؋1#/����7c��}ǭ���jB��K���_nx�G#e�9=���L=^�(�=3+ΒK����\Q�Q<O 
g�z��0a���NO�*{.�DR�v:{�����8��G���8���CX��Ϧ� xm�eǗ�M~�KO��BzJqo�I�aN�.j*�
L��[��Q[���)����aR�V#�Js )|'QML[��\V�I$����T!(��9�r�!on�.'�J���ӯT����Z���B�~!�e�\�Y�_YJ>^�xM�i��GΊ��%#H��!--_�`��=O��P��2�J���<�/���n�Gt�+���;��+#u'D&�3��ޣ��T�#'�J�[�������і�H�_d�p�����ȕG�j|>�'d�����ǂ���O�1�ٲܭ2�uhY��1�>�Mym�a:cy���߀]�`�뭳j=V`'��z��Ka�)IN��L�~����}�1��-��f�]rM�C3h��.�' ]81�:�{q.�ND�Q�AIk�T���*���r�n�.C�����҆�!G�ֺ�2k�s�l* lC�9KAMu�+��   ��ö6q�s3�p�Y����qet���H��9S�)�.��t�ٹ:�ȅ���� S	ɍ��^�����m*����t��[��ᄦ�H{�[�\E���3j9g^��5���˞���T#�$��-~��������%*��@W�� ��ݣ
��EdQ�A�\�9������|��������@����`�����W{&�`����_�9w��vEU���M�%��_Zj&�2]yJ���Xd`c}B4R9y�'�e 0�{i1���o�:'�7ps��sn���Ɩ|Tg�g= *QY��i�N�.Ȱ�R�~]�P�r��x1W��B�B�V��h�*Ֆt�p�$���{><�KnZm���l���x�x�A^�+Jb+�.N�r^=Q�]��W_�ޤ��r���1q�jL	2�@d��H��X�Γ����,L)�4R����Ėl9"�T�%��P�JI�r���y=q�O&l;�f���|D�H�4��DԌ�\1�(gx^Z
��5e(6�o�����G)J:���V�z=���^����'I&)e(ǩx>,����O[N���|�f��iv�-��h���2��y�w��۱����h�$n���W���%m,��ʈ�&s�.�)�����ZŖ���|��|9�Μ��%/Ғ_f�&S�A!�zF��j�M��o����^��^s�72��(َHȋ���?�We�����C7�%����H�k,8MW|�g��H�`;y��Xv��c¾&�%�A��F'[����#߹%���_�$�����P��l�a�+�&Ċ[�ed�-�:z���V���`��U�N��-,�&+yYY�q�}Ѐj�}>ք�`�;ft���fS^u��G���7��0��O/�K�//�o.^N��O�gϞ�?cd�      (      x��}[�Ǖ�s�W$�aiŞ��]� P�d�ؔ�-�X-Q�QU��K)/],{���1�.f��1�5vG4�1�����$�Ђ��K���9��ݔ偼~�M��U��'N��k���O���Ƀ�뒼M��O�u�d���k�j��������O����ʓ���ӟ$ճ��H>���t�?{�Q�̞=}���8���}�8��K�o���Mn'e}⓮N\R�5�N�n�3�I^旳��+���M��w�Ӽ�8���~zW���[&'y��oi]�-z��|�����uX�u���M\�W�ڼ�u��/qU��}��}%��u���z�>{�+���~X'�b��G�z��{X೧���N?vI���xY?{��l�=���9�M���wx{��\e��j�tϞ�s�s�q;����/�ٓ�VI������ݧ�������a7y����o�2���	��G���Q��M�Dj9)0L�w	.z��խ��2/�؉u�~�A����9�.����L�����*��d�2ld�S_uI�:����4�W>��%��M΁�Y^d��O�"_,�b���7$�'�u�L��������	�I_�D���䎐���O�ӏm�gO�����'7� ����6\8��ʦ�$��i�$�/�J��\Ŝ�'�՝/�_ׂ.`u����6`Q�{=��S���d��m�w��s�*CWY��^ל������%8e?�u5綵_����ԯ:]@]u�N�[�K�������M���`��Ȓ"?��#�77�de��ڕo����.q-�QW�wU�m>+�.��V|�d �2�Oz��I�쌞&�j�]�n�g��r�wʞ��?�c�B���8@I1���3��TK<�3zP�4�S颿�B�G�$S*�o%���uerk����^c־M�/�� D��U1�G�<y�Y�.ML����8�W2`��ԡ\8�ɒ��P��#D��c�d	ɜ��QN��y+[Ǣ�>���=޴i�A-����s���8h��Y�u��䥮o}��g�G�zt_�Qb��i�8�ȅf�ru�t,���o[�l Պ��,��R�si7��#uF$���Jw�UՌ�_3p�ge泦N���U��0�
z��n���y�S2ߜ2Uɞ�<��(<�m� o�n�wvy	�AHFh�.���X\�4�E+r
��$�{��$�K�=��8�)����	PVm�&��=���,;�ό6T��+%�~�����L|_�-�SP*�,�� C�8��j�x��\�i�vW����rC�u�PȠ��-�J՘X��1ᮎ�G��;�V�����Im���j��x"ȗ.wq��L�A �M�*�@�|���e�U����Y�0<���J�9�GU:P�)�����c ���S�6�� Z�gO���@�P�TKC������ry���c���ߩ��(�_U���d���EwCF��9xB����z�;�e]\���/�������	�7��w��I�3����u�;��hC+��L�Ķ��u�F�	��BXݡ>�N?�>y�S�&B��((Tqs���H���%Ĉv�KO�D>O�[ڎ�b�Ʋp3�?�A!�rp:D�>�<�-�y��4��'߫�	~ͳ؝������.��B}�y �~��ȧ��Jt��vqyM�~�|1y��)� +�=�U�g�;���U�N\�����ݸe=x8���:t�f��!C]ĴZ�ؼ�ؼ�MtS��$@�4�E��Y/ju-�"���NE��s��,���:�^�ueT���Q��� �J�< �- �Q�M��/�O?Z%;g����m�mu_��Y��"U�,��� c�d��BU�&w�v��?��  ���[l�Ɛ�!�O0�-����\���#W�˩��� �2c±��?̹ 1��e�{v�b�V�4E��3^l"�+q��å�~���&8��Fts�ŕh 0�h��vSI���\TZ��7�Q �U�m���@�J��!N}��b��,_ /��GG$&�C��$�Jc��XD�Rj�����<�@(	��xߣJH���A ~e��=��|c���[t6�z��T�T�~�#~	������10�xL��=jŴi���=�,tY�w*U�M�薂�e�fr�%^%F�1��pb�c&�v�J>�<B|����+|.�x+��aK�xIL�,t��t6M��] d�oG�z d�K�4�
!��X�M�)�6�鲢0&3U�QT�C��%���l��kăf�?�)"7��ttf��0/�*L.�a�H��E��r�/ݤÎ�%��2/�.��2��K�u*$�����4��f�U�С�@p�0*��$Z"�胋�ƭ[�Й��ApIiJ���=�L����v���<b�N�|��.����r������xٗ��{_6���-�ǸJ�fD���U��Wj'�U��y2�u��z2 t]�D��������c��Eovba�u����2K��p�
&_�FR�H��7���8�M�fH^g��)L�&JSŊ����*����B��Q/V��:|8�q3�\��U�Ù@BB�,?2j�+�9=G$��g=l�n��\�l+]EC�v.����qR�,D)F51�a�P�Z�oh��G���i�p�6w a��Z�c��� ��5���>k�ͻ�'>���4\�k��q�a��U_mrl?�v�s���eٻ�^0d{*��}ğ��:���t��2lj��߄�U��]�&��C�� KW�-����lx�	���f>? _��šA�&V��ˑ��A��*TZ�-|ؠ�<�A���z��ժ��&�\W�F�pU�M�5�G��m�;0�-��L�<捳\�Og\�Q��Jũ�ٛ�#�x�y�ݱ���55a�'�+	�~��jmִ��x̾e��%���|�mG�}��`��
� ����u�������
Z;�U�rI��Q�<ouZN�/�6��ǈ���K�W@s���˷���g��I���jﯼ;N\7���z�(�.���{0�{�R�\*�� �4ŪΫ3 �r��D��Ž��@�x�p�%��(x��Q3�١Nk�����i�V�e�ҕRe�̙;��=H�G���M@g@��d��N�Y��X`��ɞA��"61:���e�xقu����A�Ə���X����O�Y�Kx*w��n�����;���Iϙ��ޏ	%�.>��$~C��6�J�KZ7�`h����v���%H�B��m<��F���4&�\��5�<Q�B�JgN��732��'�:��}�H��3O�b4��,2$M�!x@8Q�"�u'./%`�$j�ٻ��{���f�\�Ȏ��LN D��9���Cpg�����_����A��H��1t���^ �Z�y�6��[{��<�ؒ��N�^�3�"�����Yި'�^�u���2�b<\`6y=�
�t��L_-��&�������q�c�N��[߈�S���G�`('�S�Kl�h#%���5��_�c��k_��>���ƃ��z��kV��(8����>:�������N���8�Ƹ�- r��n���cנ��0q/,��8��� 	y⪈Ƕ�_����Ǥ`���2�|)4�{'��M_�zU(��1ٿBV=�����R&���HðC�-T�$r7�vyt���ܿ��Ghz<rC�	�����@�d�p`��^Y���KK�U˕��%N0�B�/�L�)���6�+C�p̸	m
�c��`!� (�,B�8���W.x�����8J�r��+��W�Y%/*�=)|A2��.Bk�ӟ����>��g�i�*:j8 �֔;A���o ��yS}�zw��g�%n��>@	p�S#�e��ۻ��T༞C��Ōc�3���PL*�9���?���J"�Ɔ/������ap~�gM�:�;|v��O�GD�!��T]�H3���1��ժYZ������������y� �9���<B���~�yiZs7kĨ�ڏ�|�Ӱ����6���I���Y�-�/bM:xb0Kƣ>.    �̷[tĢ��o���Z䧏�����_F_�z
w��A������q���{h�#E��,ީ0�����<�����*��������LN�%��K����Z��K<���
�_d��/���Z�B~��#x�0�=|���e0&4�[��Y��K�s��$���ɛn� ���.ѫ/��%o���U� ����CiXa^E-V�@B ��GL��������������x/�yj|Xq1jM�C���Y8�@�G����eN��g��I��9"�u�%c�����1��~q����Ϛ_��O�>��gOGW�2Q��j���\-�T.{�v���\v"xA	��Bhw��/y����vE���6);��Gͧ	�$�t8�a�T�jMm����~�O��u�	H���H:��y�o��O(�gO��������$o�v��7+y7��?�P�O_Lvt�qB�>:��0�ʐ^��[G�����{Mi��'���OeV1��n��7`�*Ƅ4����9K����3��lIC���&e�0�h�����$>W�$��lru�?��p\`b��3�Wy�=�rU�#&Z�V���a�la~P�����P�$��ǇX/<bS͍�%�����\�W�������ȝDj�8������~M���O�#ߋ>�'؊gN]C���;8�b��Q=P{^�e�Hb}��0��A���P�(�|��t�o�Ry�7kP���z�}�9S��]�DQ�7�@��\� �%����C	:M��� ��(�YQ���)��x�t;N�6-�9{qר�RFZ����Y�PA�V�%��u�z�ҹ�{3wڥ��)��upk�b����B\DHN|IVç 0�8]�_�a�|���v(��ڎŶϞ�+��;��T���¶����iP�|��~�
��+yO���^�%�]@i������ú�鶴�"CП9eE[3E���y�,W��Y�-��8�N\Gy��y�P`�Y��B@���F�b4�ｘ��@�5�����Ф۾���r1� �!T�!�`���eЇE��S;z�.1�(�Y&k��F5��,�P}*�+㗲�����8����߉�*V��N�����Two�~�E\�i}z�	�)�*��-	�1��ɸ���$�T�����M^��9�b!��
Xݩ�
�3cp�*$��sX|�|-պΫ\��ۓv�1E�F�h�U�0?�</$C�#��u��k���O�y�w�y������U�krI�5�\[�~����e�8�P���*�:=�&ގ;>m�ޯv�ak}�n���K\n}��|�k;S��,;�j�^����n�iB��+g���oT��P���ީd���[�V_m���RW3n*y`��9�3i�$��1��v��^�����;x��I��ԩ�h�c�`���K�&��p�y�;��]����!<Y����q���i��|���3�;M��55}�0�́���U9�'ۣ��	�Y���$�M��F���5u/��+G���Yw����w[}�g@���)��t��$3�ԃ�[��*Q%��|���1�*��9I[�ck�-��.Eq�y�P�<CX����������׉1��h�hZ����Q���bs�/��C<�?�����cL\��p`M��.7����cw����Pe@�J\��,׻E5'@��m�ӈ�b��A��d_��ف�|Ϟ|��w5�6�q~`�
u�,5_o�4B�ͶUeמ���\1&����Gyأ%m͠��yi��T:C3�t�rԂ��Ny�0?O�+׉]��_�ڿ��?��Cs�H�N�Q�Z�
�=�g[?�|K�+ Z�M�J�s�ؼj*n�[{{��O�`ǘ	󵺂�M�ry!�D�K-x������M�%��+�%,ad6A0I�.k��6�@���U�bf�
7I���F���NC#y�aǌgIs��,�1;~Ѩ��ôpk��H��.�.q靪a	�I����`u�n`�2�T=�`�[_E����_���y���J^��y_�I�
��HA/�i��M)iX�W6f��E-�L3�׺�c^��RK��S �������ķM`$D�Pa�D[��5}�����_����-x�X�{CT��I�U48�i�A F4��^b��Mɴ?9����xhw��;P1E� ������/�k_�*1	�u6@�[q@I9
Ѷ�G�O��R#�x2n���7�j��
�SL�������a�!�j��D��B�i���-��� ����(CI�V�w�Z���1�����Z���ࠛ����%������%+j����OY���&#��:���c[X%l�P��XqN�&0}Z����V��9��R��Xzw�T�$D��ı��
˓��(/�p$n2i��̐56}�u`��A^dE>��[^c�Mޚ}%^�R _Њg���m��n��T���&y�ߐ��߬��_]�!іI,1���K^��A2�[vg.yA�w��sں���R=.E5�d�xƒ�ma���q�A{d�SC/�lѽ�"%�t��ʰI�74A�E����EHt�2si�$z��q�Z�NW[۝�9@н}j��Q�������9���==�����Wg�G\��&����3��>9��-aJ��gy~G.֒KKH3�����#��{1�2>�n�Y1P�ޟ��;��#w���E2�G�c,�w�S�1���`'ow�x+�;VL���^qQ����-�7��~:����	+2"v��Vϻ5� ��q�5A�'� e���艤��������G1���Q)}�j��J,������Cʼ�"I>X�S��wK���\]c��_������'���Ĺ�}�*9�lE�U�4w�K��os�;JS�?�sH�'�sur�^u�`�����h��yp�Dvj�vR"���E�B�uD������cx�;I�䅀K�\
Q��Z���>e�J�:.o��m��l!m���qC���:Z~��
���}_uy�$�|N��|0���!9�`�a�-Hq:���Ɗ�6l�F��y*2���L$���O�	�!�0%�������駏��ۖ!v��8��b@PJw�|<�w�֍��Wv��P�1��|1�nЍ������o�p�߭���I���a�Q���r�V����P��g��J�"k��:���j,�2�����]ճ
���4���8�IӐ.���껒+2�L)\ݛ���I���rViͥ$8�2,��M��T���$�W�u��m��ܻ8ӕ��H���o&e^�ݐF�-�[k_����J9Vf��`qaK^U�����*�
N�a�z�3�E砷��uع"�߇%�M�Д`��c��^dbz���ªt	�
D�4k/4�����1sA^q�R>;f�<�A5�a�IA���>'4D�ns��?��_5���d =D��Y�RZ�h��&����:�UO6W�Oc��D�LX�����R�#_c͗��/��j隁(	Ѵ1�	OD���9��>aI!tk�ʞ��NS�Z�*�y:����pM0�/3�٬4m0]�����u�3��ȍ|�Z�.p���vCZ	����kO����9�w6<V��W,���Fل�� �<��z�T��&�vKeN�rkZ����S1O��֐�T��\mz�W��,�ʃ� oC�Qh��H�����}��h�,URh�b|X�� W(��O�����#�f�v�˜��,jx1`�-~�  ��%��~�,]u|�?[1Qv�H�U]C��P�̪�]!z�Z�х>�?`��C	��W�R�f4E�PJ�|���<4��\�U���'3��|�CT\�J��E�B9E�)�Y]Sۆ��ꦩ��&�m�Km���PrSą��r���d�i��4�N�ByZ�֐I��i5����e%�j���$�kOr����\ipz�t*���mܒ��5$�m��[��4�F�����7��?'8%Qj�~\�Ҭ	^�R9�?�ܯ�R�>����0���� ����6�68�E����ʆ���;
w��k��Td	�Ǩ���������cF�d�!��I��4kE�vRޠ=v}R�+��Y��w[�9&�٭ӭ����~ħT!� `�oT!��    1\i��2�;��yl�V51�����FRgg%���-$I�m%�"�-�����??�o^-oM$�^3�E�&V�Km)��b�	^�>�y��xe�g�����MSU��{pi�H�99���ט�P��<��(j?/�I����*`����i�A`)�a�Gk��K�c���A��2b�]��]4[%�B�s��)��� ��j�b�Z�AtI�p����#fC�t}Uy��C��,��K��k��k�aii���85{����jq�op�KKD��XL�f�>	��q,G.�IP�'W��a�<;�������XN���,)��u�L��i�?����Z���Z�[�f���h"N�]�RL\�'�@Ѽ��'��&B�/�4JT���
"@w�1�W�� |�Tr�#��I/7�9`�r��Vc���h2)�	9�rZ��_�B��"sb���-����\dk`Y�y/y�����];�%_ˏ�@�Ī���Jg�+��+R�X��.�b3��@(�9$����Uoy�r��Rp0-�[if�qc`��"	{��]Y��P�� �[ʠ�ͼ#�]���.�D�;�m$�Q�bK"m����Jc���ɨ�Oq�C%�ݦ1��L�7&�,�ݭ�n���3�(����b��Xki?���ƌ�rF˦� _ɪ�c���׭�A ��ɧ�U5p�A,w�昙M\u�,�;)Nm�p8�e��V�.ճnAC9+���4�F���T���J�B���2�a� G���_M-�m����Q�����ǮY�0�8{ZMl�Q���ZM��ns6ǉKdS
n���J`7� �#������^���Xm�K]��ղe��G��g���`��[{�@�np!���#�"�:�6���H��*���#/���܇Cǔ(��!5uD�b9Qs����8���&,�CMf��_�M�.���ֆ�p�bY*�m�<�����K��5��H�up��&��ve��j�5�u�2e���شSg��>�X:h��Dʻ��H�hD.Z�K�y=:��
�Gr	�]*���-wC��H���Q�x��R>���}ڎ��+康��l�D��O1EKq9�H��7�3*�WHm�	c N����ni!��$s`.�\��[�ZK"�(Y(~NP#-�T3J3� �{kBIx����L���.>h�7��g���]1��?%�j�J�\��!~�̾�DJM45v��Ͱ0Qw�bTu��2k�_0�ZH�w�F/q5�$���k��������tR�9��-�D� �"Ƶy�Y�q���\�`�'���^Q5[�O�t#{B�aV�x��R�f��7�("gՊ���H�x%	��P}����W��(�\�N'9�Y/u~����p�W��vY�
��~�I�B�,�sH�֕��M��
C���s�Qb�Y�Ʌ��ٹ[`I~<DU���n-C4^[d�0�d�����w�o@OG�E�(���"7=K�*l�?/�lX��f��ZU�%+����6��;�iBMrd�NL.�΁�,'��>���/�7��6��R9�(�hP��z)w�!xr
�3��B�*M��P���tW��:րK�l�^L�i�, ��`i�IC�_�L�
K:�\�ԥ+4C�+���8��( \%CECdN񄡉֫�lYf���]���A��[�V/~Q�tI���E�Ci?k���A��|`�4N�jE���:G>����7��_Nɟ�H�6@ې.�(@dx�l�+\���1�t0�V�8?�r&�Zf蔑:��UR�,E��q�l�@�Cb�&�:4�|��xh]�/�
����!'�����������1���s��uK2ȵ��,�N7�KSv�fj�閗C�؋#/�ˍo�����[�Y�?D9P�uq:N�5|Sgm,5ጨ���Rq�[���y�P:v�z�j��h���Tme�M�Wi�N,.$	���|4��a�϶Q�0�F.�QT��uٓ���J3�;,b�=��G�NW��*�ﲁHY��W�>..����.fc�������ofw�R���u��W+���U]{�V��󦮺�Ok�	7g��K�^�v`����=��pq���h��2"S/GZ��󺪌�s���M$3�`ʓd!Ib����	�Bm���c�Q���}��z�u�w���52����Y�nJKsd�����f���"��.�<��a�9'�/��ҹϊ��.f;� ӈ�8$����]���U",N��	ߥ��X+k�� �i-�;�ӵ���^n�����qs%�TH��C�j^��k��B��38����S|ٹJz-Y���>�����q�j鿌]�ڲ>֢�y_J�]:�V�xtlK,�E����k��A*B{%��O�����j���r�Ӻ$}"$��^��$��ATNS*�� �n�����:C5���A[p[U㖉7��� Ĉ9���4G�����I�[�4+.Z�UM�VԎb����&$��q����u�C7cƢA�RrXr5��Jm�H~�~���[�	k���뤾-����Y�.���s������n��� ���Q;q�	���7��O��	]H�K�f_F5^
�����2\�$V�krB����3y'�˷Fu�rB��I	�!�/6
�X��U	�q�ͥ>Gз��)n|>�Cg��^�g�=v����P�>�C7�#c�e��ҫSe�4k�?8����Eq`.��Ǳ|o}QHo�P�	ǣ���.䂏�e1� 3��.�O���������!��+�Bk9�w��3i ˑ&Y�f�c(K @�i���ɷ�s�垟��3h�٧	޶�;�SE-m����W,�.'�TҐ`�/�b�`w�vKI�r?V
���%J��-�<�&;��yGʹ�⼰�9����K	��g҄�C�ѷf�!�?�&�}��wQH�|)y-��D�cH�4�XB���6�	H���>B/��K��c��/}�A}4��j���Uߺ��=����X��̱.3nK،:��&�0���2X���h��I���v�pY�"��Tݦ��q��1K�rNB��n��K1�/�[]��!ӆu����2��Pͻ�C���u���{�"ˎ�:[�d���Uh�Z�Y/�(Do����$T��ʘs"f�����Z�YW��暳����v���"Y�ז'�J㯥[�rʻ��Vɷla"o]2�c����Ӗ�3Gy/ Qb�r�%z��j����j�����V��l���6�����B�����z7�(�VN<�d�l�<q�7a>t�g�D���.D��� ���T�&Uamfym�5&���G�4V��k_`���Ԥh�n�U��~��{!����mud
+[4�]�c�7�ؚ�MYЕ	;�<��1�[�զV��硞�g��=�u�{�������3q�l��!�˷Q�mH����[8z��Nh
j��~�d/Ĳ�k�+�&�|f�W-%�N�g�_a1@�	ƑS�<�l��ʠRc�:g�˛�٠�֢}]�T"�{���Eb2���o]#�� �`���%n��U�w��6����8�7�y ��M�:��T���v���X4�M���Z�LzӦG����1F�0�fP���*qD�Xs���i�N+�!�OB�%z;_��{{W��B*/#&�g�+ˣ�$���Iko'�?�>9� 8JY&����q�Rou[7&�bB+��4�v���y��WO?H�)�X�xKHd��NV�73#euK�>��c&�d"C2�2Ѝ�������k^D��,��x^S{���;�������Q&��"�r�D��'�/�-1�yT��w�@�9h٣fr٢�
@�PT��bB�����cD����22����4c8���IfLr�H<x|
����[zq/�;:�3��59��*��С��E�:�3Yh���9�� &�>�!�װi�����S���ۍf���f���F�%��K�������}���Ux>W�*Ճ{�+{�J���)���U�ZD4B���:}�C4	L��܅���Jϣ���bWb�Mg�Y[��E����8p*iXݰ�U�%Q�+x/��ո�4�.�n@��γ��    贊Tyg��^�f.e�      $   n   x���A�P�5��(��_��,n�q���k7j�n&y���@N�}��. A���6Y+E!�R��Z*��K������_�5�߹���ᝍ������t���$��-*(�         x   x�M�1
�0E��S�A�h�2t钥4�hq���S9�P4�o�榷��V�D���ڥ|B$�	���8�YE;��6%4��!rW�4ͥ[��W���UN��\��3�%E��ۆ���*�         �   x�e�;�@D��à�t9AN@�O���DPp��E�2.,��َ!�T�`S�<�,ֳ�r��z�V��ld�a��A�Y~�9g�s��y���>��j�O�k�@�[ЯyK��.��m֫����Hp     