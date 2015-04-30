$(function() {
    function split( val ) {
        return val.split( /,\s*|\s+/ );
    }
    function extractLast( term ) {
        return split( term ).pop();
    }
    
    function extractLastTwo( term ) {
        var list =  split( term );
        var one  = list.pop();
        var two  = list.pop();
        if(two == undefined) {
            return one;
        }
        else {
            return two+ ' '+ one;
        }
    }
    $("#search_text").bind('keydown', function( event ) {
        if ( event.keyCode === $.ui.keyCode.SPACE) {
             $.ajax({
                    type: "POST", 
                    url: '/air/service/validate',
                    data: {
                        search_text:  $("#search_text").val()    
                    },
                    success: function (json) {
                        if(json.location == 1) {
                            $("#location").css("display", "none");
                        }
                        else {
                            $("#location").css("display", "block");
                        }
                        
                        if(json.dates == 1) {
                            $("#dates").css("display", "none");
                        }
                        else {
                            $("#dates").css("display", "block");
                        }
                        
                        if(json.passenger == 1) {
                            $("#passenger").css("display", "none");
                        }
                        else {
                            $("#passenger").css("display", "block");
                        }
                        
                        if(json.trip_details == 1) {
                            $("#trip_details").css("display", "none");
                        }
                        else {
                            $("#trip_details").css("display", "block");
                        }
                    }
                });
        }
    });

    $( "#search_text" )
        // don't navigate away from the field on tab when selecting an item
        .bind( "keydown", function( event ) {
            if ( event.keyCode === $.ui.keyCode.TAB &&
            $( this ).data( "ui-autocomplete" ).menu.active ) {
                event.preventDefault();
            }
        })
        .autocomplete({
            source: function( request, response ) {
                $.ajax({
                    type:"POST",
                    url: "/air/service/autocomplete",
                    data: {
                        option1: extractLast( request.term ),
                        option2: extractLastTwo( request.term ),
                        search_text:  request.term
                    },
                    success: function (data) {
                        //console.log(data);
                        response(data.result);
                    }
                });
            },
            search: function() {
                // custom minLength
                var term = extractLastTwo( this.value );
                if ( term.length < 3 ) {
                    return false;
                }
            },
            focus: function() {
                // prevent value inserted on focus
                return false;
            },
            select: function( event, ui ) {
                var last    = split(extractLastTwo( this.value ));                
                var terms   = split( this.value );
                var cterms  = split( this.value );                
                var newitem = split(ui.item.value);
                
                var clen    = cterms.length - 1;
                var cnt     = 0;
                for(i = newitem.length - 1; i >= 0; i--, clen--){
                    try {
                        if(newitem[i].toLowerCase() == cterms[clen].toLowerCase()) {
                            cnt++;
                        }
                    }
                    catch(e){
                        break;
                    }                    
                }
                
                if(cnt == newitem.length && cnt != 0 ) {
                    //console.log('matched count');                    
                    return false;
                }
                //console.log(last[0]);
                //console.log(last[1]);
                
                //console.log(newitem[0]);
                //console.log(newitem[1]);
                
                // remove the current input
                terms.pop();
                
                if(last[0].toLowerCase() == newitem[0].toLowerCase() && last[1] != undefined) {
                    // remove the second last input as well
                    terms.pop();
                }
                
                // add the selected item
                terms.push( ui.item.value );
                // add placeholder to get the comma-and-space at the end
                terms.push( "" );
                this.value = terms.join( " " );
                
                return false;
            }
        });
    }
);
