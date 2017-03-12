var _accuSchedule$Native$Asciidoc = function() {

var asciidoctor = Asciidoctor();

// VIRTUAL-DOM WIDGETS

function toHtml(factList, rawAsciidoctor)
{
	var model = {
		asciidoctor: rawAsciidoctor
	};
	return _elm_lang$virtual_dom$Native_VirtualDom.custom(factList, model, implementation);
}


// WIDGET IMPLEMENTATION

var implementation = {
	render: render,
	diff: diff
};

function render(model)
{
	var html = asciidoctor.convert(model.asciidoctor);
	var div = document.createElement('div');
	div.innerHTML = html;
	return div;
}

function diff(a, b)
{

	if (a.model.asciidoctor === b.model.asciidoctor)
	{
		return null;
	}

	return {
		applyPatch: applyPatch,
		data: asciidoctor(b.model.asciidoctor)
	};
}

function applyPatch(domNode, data)
{
	domNode.innerHTML = data;
	return domNode;
}

// TODO: Consider embedding asciidoctor.js directly here, like elm-markdown

// EXPORTS

return {
	toHtml: F2(toHtml)
};

}();
