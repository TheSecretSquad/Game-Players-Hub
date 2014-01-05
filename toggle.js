/*
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:     toggle.js
Author:   Peter DiSalvo
Date:     April 2012

Purpose:  Functions used to toggle classes on html elements.
*/


/*
**	Checks if the given element has the specified class.
**	Returns the index of the class in the class list, or
**	-1 if it does not exist.
*/
function hasClass(element, className)
{
	return element.className.split(' ').indexOf(className);
}
          
/*
**	Replaces 'class1' with 'class2' or vice versa on
**	the specified element.
*/
function toggleElementClass(element, class1, class2)
{
	var classes = element.className.split(' ');
          
	if (hasClass(element, class1) !== -1)
	{
		classes[classes.indexOf(class1)] = class2;
		element.className = classes.toString().replace(',', ' ');
	}
	else if (hasClass(element, class2) !== -1)
	{
		classes[classes.indexOf(class2)] = class1;
		element.className = classes.toString().replace(',', ' ');
	}
}
          
/*
**	Shows (displays) or hides the parent element of
**	the given event object. For browsers that utilize a
**	global event object, the global event object is used
**	instead of the parameter.
*/     
function showHideParent(event)
{
	var eventObject;
	var eventTarget;
	
	if(event)
	{
		eventTarget = event;
	}
	else
	{
		eventObject = window.event;
		eventTarget = (eventObject.target ? eventObject.target : eventObject.srcElement);
	}
          
	var showHideElem = eventTarget.parentNode;
          
	toggleElementClass(showHideElem, "detailsClosed", "detailsOpen");
          
	toggleElementClass(eventTarget, "closed", "open");
}