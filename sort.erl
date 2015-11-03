-module(sort). 
-export([qsort/1,pqsort3/1,random_list/1,mergeSort/1]).

qsort([]) -> [];
qsort([P|Xs]) ->
    qsort([X || X <-Xs,X =< P])
	++ [P]  % pivot element ++ qsort([X || X <-Xs,P < X])
	++ qsort([X || X <-Xs,P < X]).



pqsort3(L) -> pqsort3(5, L).
pqsort3(0, L) -> qsort(L);
pqsort3(_, []) -> [];
pqsort3(D, [P|Xs]) -> 
    Par = self(),
    Ref = make_ref(),
    spawn_link(fun () ->
		       Gs = [X || X <-Xs, P < X],
		       Par ! {Ref, pqsort3(D-1, Gs)} 
	       end),
    pqsort3(D-1, [X || X <-Xs, X =< P])
	++ [P]
	++ receive {Ref, Ys} -> Ys end.

random_list(N) ->
    [random:uniform(12345678)|| _<-lists:seq(1,N)].




merge_sort([]) -> [];
merge_sort([A]) -> [A];
merge_sort(List) ->
    {ListA, ListB} = split(List),
    merge(mergeSort(ListA), mergeSort(ListB), []).


merge_sort([]) -> [];
merge_sort([A]) -> [A];
merge_sort(List) ->
    {ListA, ListB} = split(List),
    merge(merge_sort(ListA), merge_sort(ListB), []).
        

split(List) -> 
    lists:split(length(List) div 2, List).

merge(ListA,ListB,ListC) ->
    if 
	length(ListA) == 0 ->
	    lists:reverse(lists:reverse(ListB) ++ ListC);
	length(ListB) == 0 ->
	    lists:reverse(lists:reverse(ListA) ++ ListC);
	true ->
	    if 
		hd(ListA) < hd(ListB) ->
		    merge(tl(ListA), ListB, [hd(ListA)|ListC]);
		true ->
		    merge(ListA, tl(ListB), [hd(ListB)|ListC])
	    end
    end.
