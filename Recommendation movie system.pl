%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          RECOMMENDATION CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this is the start of the system
start:-
write('%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
write('Welcom to our movie recommendation expert system'),nl,
write('%%%%%%%%%%%%%%%%%%%%%%%%'), nl,nl,
write('To recommend a suitable movie for you, we need some information from you first..'),nl,
write('========================='), nl,
menu.
menu:-
write('Choose the MPAA rating:'),nl,
write('1/ G: General audiences'),nl,
write('2/ PG: Parental Guidance suggested'),nl,
write('3/ PG-13: Parents Strongly Cautioned'),nl,
write('4/ R: Restricted.\n'),nl,
    validate_input_condition_type(MPAA),
write('DO you prefer specific service:'),nl,
write('1/ Yes'),nl,
write('2/ No matter'),nl,
    validate_input_two_options(Stream),
     stream_list(MPAA,Stream).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          validate input rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
validate_input_condition_type(N) :-
    read(N),  % get user input
    number(N),N>0, N<5, !  % exit goal, is it a number?
    ; writeln('Please enter number between 1 and 4'), validate_input_condition_type(N).  % recursive call if not number

validate_input_rate(N) :-
    read(N),  % get user input
    number(N),N>0, N<6, !  % exit goal, is it a number?
    ; writeln('Please enter number between 1 and 5'), validate_input_rate(N).  % recursive call if not number

validate_input_three_options(N) :-
    read(N),  % get user input
    number(N),N>0, N<4, !  % exit goal, is it a number?
    ; writeln('Please enter number between 1 and 3'), validate_input_three_options(N).  % recursive call if not number

validate_input_two_options(N) :-
    read(N),  % get user input
    number(N),N>0, N<3, !  % exit goal, is it a number?
    ; writeln('Please enter 1 or 2'), validate_input_two_options(N).  % recursive call if not number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                when stream no matter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stream_list(MPAA,2):-
write('How long should a movie be?'),nl,
write('1/ 1 to 2 hours'),nl,
write('2/ Over 2 hours'),nl,
    validate_input_two_options(Long),
write('How would you react to the movie?'),nl,
write('1/ Happy'),nl,
write('2/ Sad'),nl,
write('3/ Thirller'),nl,
    validate_input_three_options(Mood),
write('What genre of movie do you like?'),nl,
write('1/ Drama'),nl,
write('2/ Action'),nl,
write('3/ Sci-Fi'),nl,
write('4/ Animation'),nl,
    validate_input_condition_type(Type),

write('Choose movie rating?'),nl,
write('1/ 5+'),nl,
write('2/ 6+'),nl,
write('3/ 7+'),nl,
write('4/ 8+'),nl,     
    validate_input_condition_type(Rating),

matching(MPAA,2,0,Long,Mood,Type,Rating).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                when stream matter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stream_list(MPAA,1):-
write('1/ Netflix'),nl,
write('2/ Apple TV'),nl,
write('3/ Disney'),nl,
validate_input_three_options(Stream_choice),
write('How long should a movie be?'),nl,
write('1/ 1 to 2 hours'),nl,
write('2/ Over 2 hours'),nl,
    validate_input_two_options(Long),
write('How would you react to the movie?'),nl,
write('1/ Happy'),nl,
write('2/ Sad'),nl,
write('3/ Thirller'),nl,
    validate_input_three_options(Mood),
write('What genre of movie do you like?'),nl,
write('1/ Drama'),nl,
write('2/ Action'),nl,
write('3/ Sci-Fi'),nl,
write('4/ Animation'),nl,
    validate_input_condition_type(Type),
write('Choose movie rating?'),nl,
write('1/ 5+'),nl,
write('2/ 6+'),nl,
write('3/ 7+'),nl,
write('4/ 8+'),nl,     
    validate_input_condition_type(Rating),

matching(MPAA,1,Stream_choice,Long,Mood,Type,Rating).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         recommendation rule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
matching(MPAA,Stream,Stream_choice,Long,Mood,Type,Rating):-
call(movie_preferences(MPAA,Stream,Stream_choice,Long,Mood,Type,Rating,_)),!,
recommendation(MPAA,Stream,Stream_choice,Long,Mood,Type,Rating);
    notMatch.
 recommendation(MPAA,Stream,Stream_choice,Long,Mood,Type,Rating):-
    findall(Movie_name,movie_preferences(MPAA,Stream,Stream_choice,Long,Mood,Type,Rating,Movie_name),List_movie),
    write('=========================================================================='), nl,
    print(List_movie),
    write(" is recommended"),nl,
    continue_system.
    
notMatch:-
    writeln("Sorry, the system could not find a suitable movie for your preferences, you can try again"),
    continue_system.
continue_system:-
      write("Would you want to use the system again? "),nl,
    write('1/ Yes'),nl,
    write('2/ No'),nl,
    validate_input_two_options(Again),
    Again == 1 -> menu;exit_system.  
exit_system:-
    nl,
    write('=============================='),nl,
    write('THANK YOU FOR USING OUR SYSTEM'),nl,
    write('=============================='),nl,abort.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Our Database
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
movie_preferences(1,2,0,2,2,1,4,'Rain Man').
movie_preferences(1,2,0,1,1,4,2,'Luck').
movie_preferences(4,1,2,2,2,3,2,'Bird Box').
movie_preferences(3,2,0,2,3,2,3,'Mission: Impossible - Fallout').
movie_preferences(3,2,0,2,3,2,4,'Top Gun: Maverick').
movie_preferences(3,1,1,1,1,1,4,'Coda').
movie_preferences(3,1,2,1,1,1,4,'Coda').
movie_preferences(3,1,1,1,3,1,3,'Greyhound').
movie_preferences(3,1,1,1,3,2,3,'Greyhound').
movie_preferences(3,1,1,2,2,1,3,'The banker').
movie_preferences(3,1,1,2,1,1,4,'Green Book').
movie_preferences(3,1,1,2,2,1,3,'King Richard').
movie_preferences(4,1,1,2,3,2,2,'Emanciption').
movie_preferences(4,1,1,1,2,1,4,'1917').
movie_preferences(4,1,1,1,2,2,4,'1917').
movie_preferences(4,1,1,1,2,1,4,'Joker').
movie_preferences(2,1,1,1,1,4,4,'Soul').
movie_preferences(2,1,1,1,1,4,4,'COCO').
movie_preferences(2,1,1,1,1,4,3,'Encanto').
movie_preferences(4,1,2,2,2,3,2,'Bird Box').
movie_preferences(4,1,2,2,1,1,3,'Once Upon a Time in Hollywood').
movie_preferences(1,1,2,2,2,1,3,'Titanic').
movie_preferences(3,1,2,1,3,1,2,'Jack Reacher: Never Go Back').
movie_preferences(3,1,2,1,3,2,2,'Jack Reacher: Never Go Back').
movie_preferences(4,1,2,2,1,1,3,'Jerry Maguire').
movie_preferences(4,1,2,1,3,2,1,'Night Hunter').
movie_preferences(2,1,1,1,1,4,3,'Moana').
movie_preferences(3,1,1,2,1,2,2,'Jungle Cruise').
movie_preferences(1,1,1,2,3,1,4,'Interstellar').
movie_preferences(1,1,1,2,3,3,4,'Interstellar').
movie_preferences(1,1,1,2,1,1,3,'Sense and Sensibilty').
movie_preferences(4,1,2,2,2,1,3,'Do not Look Up').
movie_preferences(4,1,2,2,2,3,3,'Do not Look Up').
movie_preferences(4,1,2,2,2,3,3,'Do not Look Up').
movie_preferences(1,1,1,1,1,4,3,'Ponyo').
movie_preferences(1,1,1,2,3,4,4,'SpirIted Away').
movie_preferences(1,1,1,2,3,4,4,'Castle in The Sky').
movie_preferences(1,1,1,1,1,4,4,'My Neighbor TOTORO').
movie_preferences(2,1,1,2,2,1,3,'Little Women').
movie_preferences(3,1,3,2,3,1,4,'Catch Me If You Can').
movie_preferences(3,1,3,2,2,1,2,'Enola Holmes').
movie_preferences(3,1,3,2,2,2,2,'Enola Holmes').
movie_preferences(3,1,2,2,3,2,3,'Man of Steel').
movie_preferences(3,1,2,2,3,3,3,'Man of Steel').
movie_preferences(3,1,3,2,3,2,3,'Man of Steel').
movie_preferences(3,1,3,2,3,3,3,'Man of Steel').
movie_preferences(3,1,2,1,3,2,2,'San Andreas').
movie_preferences(3,1,3,1,3,2,2,'San Andreas').
movie_preferences(3,1,2,1,1,2,2,'Jumanji: Welcome to the Jungle').
movie_preferences(3,1,3,1,1,2,2,'Jumanji: Welcome to the Jungle').
movie_preferences(3,1,2,1,3,2,2,'Red Notice').
movie_preferences(3,1,2,1,3,2,3,'Dunkirk').
movie_preferences(3,1,2,1,3,1,3,'Dunkirk').
movie_preferences(3,1,2,2,2,1,3,'The Notebook').
movie_preferences(3,1,2,2,3,2,2,'The Gray Man').
movie_preferences(3,1,2,2,2,1,3,'The Swimmers').                                                                                        