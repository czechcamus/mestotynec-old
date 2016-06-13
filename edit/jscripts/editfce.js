// enable or disable fields
	function switchdisable(naz1,naz2,naz3)
		{
		box =  document.getElementById(naz1);
		povol = document.getElementById(naz2).value;
		if (povol) {
			pole_povol = povol.split(",");
			for (i=0;i<pole_povol.length;++i) {
				nazev_povol = document.getElementById(pole_povol[i]);
				if (box.checked && nazev_povol.disabled==true) {
					if (box.name=="maininfo") {
							if  (nazev_povol.type=="checkbox") {
								nazev_povol.disabled=false;
							}
						}
					if (box.name!="maininfo") {
							nazev_povol.disabled=false;
						}
					}
				if (box.checked==false && nazev_povol.disabled==false) {
					if (nazev_povol.checked) {
						nazev_povol.checked=false;
						}
					nazev_povol.disabled=true;
					}
				}
			}
		nepovol = document.getElementById(naz3).value;
		if (nepovol) {
			pole_nepovol = nepovol.split(",");
			for (i=0;i<pole_nepovol.length;++i) {
				nazev_nepovol = document.getElementById(pole_nepovol[i]);
				if (box.checked && nazev_nepovol.disabled==false) {
					if (nazev_nepovol.checked) {
						nazev_nepovol.checked=false;
						}
					nazev_nepovol.disabled=true;
					}
				if (box.checked==false && nazev_nepovol.disabled==true) {
					nazev_nepovol.disabled=false;
					}
				}
			}
		}
		
// enable or disable select options
	function switchlistitemtype(naz1,naz2,naz3)
		{
		sel =  document.getElementById(naz1);
		if (sel.options[sel.selectedIndex].value=="ul") {
			povol = document.getElementById(naz2).value;
			nepovol = document.getElementById(naz3).value;
		} else {
			povol = document.getElementById(naz3).value;
			nepovol = document.getElementById(naz2).value;
		}
		if (povol) {
			pole_povol = povol.split(",");
			for (i=0;i<pole_povol.length;++i) {
				nazev_povol = document.getElementById(pole_povol[i]);
				nazev_povol.disabled=false;
				}
			}
		if (nepovol) {
			pole_nepovol = nepovol.split(",");
			for (i=0;i<pole_nepovol.length;++i) {
				nazev_nepovol = document.getElementById(pole_nepovol[i]);
				nazev_nepovol.disabled=true;
				}
			}
		}	

// enable or disable file upload field
	function switchlistdisable(naz1,naz2)	
		{
		sel = document.getElementById(naz1);
		if (sel.options[sel.selectedIndex].value=="s") {
			povol = document.getElementById(naz2).value;
			if (povol) {
				pole_povol = povol.split(",");
				for (i=0;i<pole_povol.length;++i) {
					nazev_povol = document.getElementById(pole_povol[i]);
					nazev_povol.disabled=false;
					}
				}
		} else {
			nepovol = document.getElementById(naz2).value;
			if (nepovol) {
				pole_nepovol = nepovol.split(",");
				for (i=0;i<pole_nepovol.length;++i) {
					nazev_nepovol = document.getElementById(pole_nepovol[i]);
					nazev_nepovol.disabled=true;
					}
				}
			}	
		}

// enable text wrapping in mozilla - thanks to ondra pekarek
	function mozWrap(txtarea,lft,rgt)
		{
		var selLength = txtarea.textLength;
		var selStart = txtarea.selectionStart;
		var selEnd = txtarea.selectionEnd;
		if (selEnd==1 || selEnd==2) selEnd=selLength;
		var s1 = (txtarea.value).substring(0,selStart);
		var s2 = (txtarea.value).substring(selStart, selEnd)
		var s3 = (txtarea.value).substring(selEnd, selLength);
		txtarea.value = s1 + lft + s2 + rgt + s3;
		}
	
// enable text wrapping in IE - thanks to ondra pekarek
	function IEWrap(lft, rgt)
		{
		strSelection = document.selection.createRange().text;
		if (strSelection!="")
			{
			document.selection.createRange().text = lft + strSelection + rgt;
		} else {
		    alert ("Musíte vybrat text!");
		    }	
		}
	
// enable text wrapping - thanks to ondra pekarek
	function wrapSelection(txtarea, lft, rgt)
		{
		if (document.all) 
			{
				IEWrap(lft, rgt);
			}
		else if (document.getElementById) 
			{
				mozWrap(txtarea, lft, rgt);
			}
		}
		
// enable text wrapping for links - thanks to ondra pekarek
	function wrapSelectionWithLink(txtarea)
		{
		var my_link = prompt("Vložte URL:","http://");
		if (my_link != null)
			{
				lft="<a href=\"" + my_link + "\">";
				rgt="</a>";
				wrapSelection(txtarea, lft, rgt);
			}
		}

// uncheck and check checkboxes
	function uncheckbox(naz1,naz2,naz3)
		{
		box =  document.getElementById(naz1);
		nepovol = document.getElementById(naz3).value;
		if (nepovol) {
			pole_nepovol = nepovol.split(",");
			for (i=0;i<pole_nepovol.length;++i) {
				nazev_nepovol = document.getElementById(pole_nepovol[i]);
				if (box.checked && nazev_nepovol.checked==true) {
					nazev_nepovol.checked=false;
					}
				}
			}
		zaskrt = document.getElementById(naz2).value;
		if (zaskrt) {
			pole_zaskrt = zaskrt.split(",");
			for (i=0;i<pole_zaskrt.length;++i) {
				nazev_zaskrt = document.getElementById(pole_zaskrt[i]);
				if (box.checked && nazev_zaskrt.checked==false) {
					nazev_zaskrt.checked=true;
					}
				}
			}
		}
