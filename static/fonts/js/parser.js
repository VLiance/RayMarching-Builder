(function(){
    let app = {};
    app["objects"] = [];

    // First load the data asynchronously
    $.getJSON( "data/data.json",function( data ) {
        checkConfiguration(data)
    });

    //When the document is ready start the init function
    $(document).ready(init);

    // Check app config file
    function checkConfiguration(data){
        app["data"]= data;
        let distance_functions = data["distance_functions"]
        $.each(distance_functions, function(key,value){
            //console.log("name of the functions: " + value["name"]);
        })
    }

    // Init function
    function init(){
        // Set the event listener for viewport changing
        initParams();
        // Set the initial view size
        setViewSize();
        $(window).resize(setViewSize);

        // Wait until the configuration file has loads
        while($.isEmptyObject(app)){
            if(app["show-loading"]) {
                console.log("Loading the app configuration file");
                app["show-loading"] = false;
            }     
        }

        // At this point the configuration file has been loaded and parse to a js object
        fillTools();

        draw();
    }

    function initParams(){
        app["aspect-ratio"] = 16/9;
        app["show-loading"] = true;
        app["canvas"] = document.getElementById("main-canvas");
    }

    function setViewSize(factor){
        const window = $("#top");
        let cnvs= $("#main-canvas");
        let newWidth = cnvs.width();
        let newHeight = Math.min(cnvs.width()*(1/app["aspect-ratio"]),window.height());
        app["width"] = newWidth;
        app["height"] = newHeight;
        // Styling values
        cnvs.height(newHeight);
        cnvs.width(newWidth);
        // Html values
        cnvs.attr("width", newWidth);
        cnvs.attr("height", newHeight);

        draw();
    }

    function draw(){
        const c = app["canvas"];
        const w = app["width"];
        const h = app["height"];
        const ctx = c.getContext("2d");
        // Title
        let titleSizeFactor = 19;
        ctx.textAlign = "center";
        ctx.font = Math.round(w/titleSizeFactor)+"px Red Hat Display";
        ctx.fillStyle = "#333333";
        const title = "Ray Marching";
        ctx.fillText( title, w/2, h/2);
        // Description
        let descriptionSizeFactor = 59;
        ctx.textAlign = "center";
        ctx.font = Math.round(w/descriptionSizeFactor)+"px Red Hat Display";
        ctx.fillStyle = "#333333";
        const description = "Where rays intersect";
        ctx.fillText( description, w/2, h/2 + 40);
        ctx.beginPath();
        ctx.moveTo(w/2-150, h/2+20);
        ctx.lineTo(w/2+150, h/2+20);
        ctx.stroke();
    }

    function fillTools(){
        let df = app["data"]["distance_functions"];
        let uo = app["data"]["unary_operators"];
        let bo = app["data"]["binary_operators"];

        fillToolsSection(df,"#tools-surfaces");
        fillToolsSection(uo,"#tools-unary-operators");
        fillToolsSection(bo,"#tools-binary-operators");
    }

    function fillToolsSection(arr, sectionId){
        let s = $(sectionId);
        if(arr != undefined && s != undefined) {
            arr.forEach(function (elem) {
                let name = elem.name;
                let link = $(document.createElement("a")).text(name);
                link.click(function(){
                    let propertiesForm = $("#properties-form");
                    propertiesForm.empty();
                    propertiesForm.append(setUpForm(elem));
                })
                link.attr("href","#");
                let li = $(document.createElement("li")).append(link);
                s.append(li);
            });
        }
    }

    function setUpForm(elem){
        let args = elem["arguments"];
        let form = $(document.createElement("form")).addClass( "form-box styled-box" );
        let fieldset = $(document.createElement("fieldset"));
        let legend = $(document.createElement("legend")).text(elem["name"]);
        fieldset.append(legend);
        args.forEach(function(arg){
            fieldset.append(transformArgumentToFormInputs(arg));
        })
        let submitButton = $(document.createElement("input")).attr("type","submit").attr("value","Ok!");
        fieldset.append(submitButton);
        form.append(fieldset);
        form.submit(function( event ) {
            event.preventDefault();
            // Validate the current form
            app["objects"].push(validateForm(elem));
            updateObjectsList();
            console.log(app["objects"]);
        });
        return form;
    }

    function transformArgumentToFormInputs(arg){
        let name = arg["name"];
        let type  = arg["type"];
        let required = arg["required"];
        let container;

        switch(type){
            case "float":
                container = createMultipleInputArgument(
                name, 
                [
                    {"type": "number", "placeholder": name, "step":"0.001"}
                ],
                required);
                break;
            case "vec2":
                container = createMultipleInputArgument(
                name,
                [
                    {"type": "number", "placeholder":"x", "step":"0.001"},
                    {"type": "number", "placeholder":"y", "step":"0.001"}
                ],
                required);
                break;
            case "vec3":
                container = createMultipleInputArgument(
                    name,
                    [
                    {"type": "number", "placeholder":"x", "step":"0.001"},
                    {"type": "number", "placeholder":"y", "step":"0.001"},
                    {"type": "number", "placeholder":"z", "step":"0.001"}
                ],
                required);
                break;
            case "vec4":
                container = createMultipleInputArgument(
                    name,
                    [
                    {"type": "number", "placeholder":"x", "step":"0.001"},
                    {"type": "number", "placeholder":"y", "step":"0.001"},
                    {"type": "number", "placeholder":"z", "step":"0.001"},
                    {"type": "number", "placeholder":"w", "step":"0.001"}
                ],
                required);
                break;
            default:
                break;
        }

        return container;
    }

    function createMultipleInputArgument(name, arr, required) {
        let container = document.createElement("div");

        let titleContainer = document.createElement("h4");
        let title = document.createTextNode(name); 
        titleContainer.appendChild(title);
        container.appendChild(titleContainer);

        arr.forEach(function (elem) {
            let row = document.createElement("div");
            let input = document.createElement("input");
            input.setAttribute("type", elem["type"]);
            input.setAttribute("name",name+"-"+elem["placeholder"])
            input.setAttribute("placeholder", elem["placeholder"]);
            input.setAttribute("step",elem["step"]);
            if(required){
                input.setAttribute("required","");
            }
            row.appendChild(input);
            container.appendChild(row);
        })

        return container;
    }

    function validateForm(elem){
        let args = elem["arguments"];
        let finalObject = {};
        finalObject["name"] = elem["name"];
        args.forEach(function(arg){
            let name = arg["name"];
            let type = arg["type"];
            let argOption;
            switch(type){
                case "float":
                    argOption = validateArgument(name, [name]);
                    break;
                case "vec2":
                    argOption = validateArgument(name, ["x", "y"]);
                    break;
                case "vec3":
                    argOption = validateArgument(name, ["x","y","z"]);
                    break;
                case "vec4":
                    argOption = validateArgument(name, ["x","y","z","w"]);
                    break;
            }

            if(!argOption["valid"]) {
                alert("The parameters you entered were incorrect");
                return;
            } else{
                finalObject[arg["name"]] = argOption["validArguments"];
            }
                
        });
        return finalObject;
    }

    function validateArgument(name,vector){
        let valid = true;
        let validArguments = [];

        for(let i=0; i<vector.length; i++){
            let input = $("input[name=\""+name+"-"+vector[i]+"\"]");
            let value = input.val();

            if (typeof value !== 'undefined' && !Number.isNaN(value)) {
                validArguments[i]= parseFloat(value);
            } else {
                valid = false;
                break;
            }
        }

        return {"valid": valid, "validArguments": validArguments};
    }

    function updateObjectsList(){
        let objectsListNode = $("#objects-list");
        objectsListNode.empty();
        let objList = app["objects"];
        
        if(objList.length == 0) {
            objectsListNode.append("<li>No objects</li>");
            return
        }

        for(let i= 0; i< objList.length; i++){
            obj = objList[i];
            let li = document.createElement("li");
            li.setAttribute("id","obj-"+i.toString());

            let objName = document.createElement("span");
            objName.appendChild(document.createTextNode(obj["name"]+ " " + i.toString()));

            let deleteLink = document.createElement("a");
            deleteLink.setAttribute("href","#");

            $(deleteLink).click(function(){
                if (confirm("Are you sure you want to delete the objet")) {
                    let parent = this.parentNode;
                    if (parent) {
                        console.log(parent);
                        let parentId = parent["id"];
                        let objectId = (parentId.split("-"))[1];
                        if (objectId > -1) {
                            app["objects"].splice(objectId, 1);
                            updateObjectsList();
                        }
                    }
                  } else {
                    txt = "You pressed Cancel!";
                  }
            });

            let deleteIcon = document.createElement("i");
            deleteIcon.appendChild(document.createTextNode("x"));
            $(deleteIcon).addClass("icon-delete");
            deleteLink.appendChild(deleteIcon);

            li.appendChild(objName);
            li.appendChild(deleteLink);

            objectsListNode.append($(li));
        }
    }
})();




