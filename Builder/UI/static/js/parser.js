const appData = {
	"distance_functions":[
		{
			"name":"sphere",
			"arguments":[
				{
					"name":"radius",
					"type":"float",
					"required":true
				}
            ],
            "function": `
float sphere( vec3 p, float s )
{
    return length(p)-s;
}
`
		},
		{
			"name":"capsule",
			"arguments":[
				{
					"name":"a",
                    "type":"vec3",
                    "required":true
				},
				{
					"name":"b",
                    "type":"vec3",
                    "required":true
				},
				{
					"name":"radius",
                    "type":"float",
                    "required":true
				}
            ],
            "function": `
float capsule( vec3 p, vec3 a, vec3 b, float r )
{
    vec3 pa = p - a, ba = b - a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h ) - r;
}
            `
		},
		{
			"name":"ellipsoid",
			"arguments":[
				{
					"name":"radius",
                    "type":"vec3",
                    "required":true
				}
            ],
            "function": `
float ellipsoid( in vec3 p, in vec3 r )
{
    float k0 = length(p/r);
    float k1 = length(p/(r*r));
    return k0*(k0-1.0)/k1;
}
            `
		},
		{
			"name":"octahedron",
			"arguments":[
				{
					"name":"s",
                    "type":"float",
                    "required":true
				}
            ],
            "function": `
float octahedron( in vec3 p, in float s)
{
    p = abs(p);
    float m = p.x+p.y+p.z-s;
    vec3 q;
            if( 3.0*p.x < m ) q = p.xyz;
    else if( 3.0*p.y < m ) q = p.yzx;
    else if( 3.0*p.z < m ) q = p.zxy;
    else return m*0.57735027;
    
    float k = clamp(0.5*(q.z-q.y+s),0.0,s); 
    return length(vec3(q.x,q.y-s+k,q.z-k)); 
}
            `
		}
	],
	"unary_operators":[
		{
			"name":"scale",
			"arguments":[
				{
					"name":"p",
                    "type":"vec3",
                    "required":true
				},
				{
					"name":"s",
                    "type":"float",
                    "required":true
				}
			]
        },
        {
			"name":"translation",
			"arguments":[
				{
					"name":"t",
                    "type":"vec3",
                    "required":true
				}
			]
		},
		{
			"name":"repetition",
			"arguments":[
				{
					"name":"c",
                    "type":"vec3",
                    "required":true
				}
			]
		},
		{
			"name":"displacement",
			"arguments":[
				{
					"name":"displacement vector",
                    "type":"vec3",
                    "required":true
				}
			]
		},
		{
			"name":"twist",
			"arguments":[
				{
					"name":"twist vector",
                    "type":"vec3",
                    "required":true
				},
				{
					"name":"factor",
                    "type":"float",
                    "required":true
				}
			]
		}
	],
	"binary_operators":[
		{
			"name":"union",
			"arguments":[

			]
		},
		{
			"name":"subtraction",
			"arguments":[

			]
		},
		{
			"name":"intersection",
			"arguments":[

			]
		},
		{
			"name":"smooth union",
			"arguments":[
				{
					"name":"factor",
					"type":"float"
				}
			]
		},
		{
			"name":"smooth subtraction",
			"arguments":[
				{
					"name":"factor",
					"type":"float"
				}
			]
		},
		{
			"name":"smooth intersection",
			"arguments":[
				{
					"name":"factor",
					"type":"float"
				}
			]
		}
	]
};

(function(){
    let app = {};
    $(document).ready(init);

    // Init function
    function init(){
        // Load the data
        app["data"] = appData;
        // Number of decimals for floats
        app["floatPrecision"] = 3
        // Set the event listener for viewport changing
        initParams();
        // Set the initial view size
        setViewSize();
        $(window).resize(setViewSize);

        // At this point the configuration file has been loaded and parse to a js object
        fillTools();

        //draw();
    }

    function initParams(){
        app["aspect-ratio"] = 16/9;
        app["show-loading"] = true;
        app["canvas"] = document.getElementById("main-canvas");
    }

    function setViewSize(factor){
        const window = $("#top");
        let cnvs= $("#gze_canvas");
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
        let sectionName = sectionId.split(/-(.+)/)[1];
        if(arr != undefined && s != undefined) {
            arr.forEach(function (elem) {
                let name = elem.name;
                let link = $(document.createElement("a")).text(name);
                link.click(function(){
                    let propertiesForm = $("#properties-form");
                    propertiesForm.empty();
                    propertiesForm.append(setUpForm(sectionName, elem));
                })
                link.attr("href","#");
                let li = $(document.createElement("li")).append(link);
                s.append(li);
            });
        }
    }

    function setUpForm(sectionName, elem){
        if(typeof sectionName === "undefined"){
            return;
        }

        if(typeof app["objects"] === "undefined") {
            app["objects"] = new Map();
        }

        let args = elem["arguments"];
        let form = $(document.createElement("form")).addClass( "form-box styled-box" );
        let fieldset = $(document.createElement("fieldset"));
        let legend = $(document.createElement("legend")).text(elem["name"]);
        fieldset.append(legend);
        let nameInput = "";
        let objList = app["objects"];
        let objSelect;
        let objSelect1;
        let objSelect2;
        switch(sectionName){
            case "surfaces":
                nameInput = $(document.createElement("input"))
                .attr("type","text")
                .attr("required","")
                .attr("placeholder", elem["name"]);
                fieldset.append(nameInput);
                break;
            case "unary-operators":
                objSelect = $(document.createElement("select")).attr("name","objectsSelect");
                objList.forEach(function(obj, key, map){
                    let option = $(document.createElement("option")).attr("value",obj.uuid).text(obj.name);
                    objSelect.append(option);
                })
                fieldset.append($(document.createElement("div")).append(objSelect));
                break;
            case "binary-operators":
                nameInput = $(document.createElement("input"))
                    .attr("type","text")
                    .attr("required","")
                    .attr("placeholder", elem["name"]);
                    fieldset.append(nameInput);
                objSelect1 = $(document.createElement("select")).attr("name","objectsSelect1");
                objSelect2 = $(document.createElement("select")).attr("name","objectsSelect2");
                objList.forEach(function(obj, key, map){
                    let optionList1 = $(document.createElement("option")).attr("value",obj.uuid).text(obj.name);
                    objSelect1.append(optionList1);
                    let optionList2 = $(document.createElement("option")).attr("value",obj.uuid).text(obj.name);
                    objSelect2.append(optionList2);
                })
                fieldset.append($(document.createElement("div")).append(objSelect1));
                fieldset.append($(document.createElement("div")).append(objSelect2));
                break;
        }
        args.forEach(function(arg){
            fieldset.append(transformArgumentToFormInputs(arg));
        })
        let submitButton = $(document.createElement("input")).attr("type","submit").attr("value","Ok!");
        fieldset.append(submitButton);
        form.append(fieldset);
        form.submit(function( event ) {
            event.preventDefault();
            // Validate the current form
            switch(sectionName){
                case "surfaces":
                    let newObject = {}
                    // Each object has a user defined-name
                    newObject["name"] = nameInput.val();
                    // Store the original type of the object
                    newObject["originalType"] = elem["name"];
                    // Give to the object a uuid
                    newObject["uuid"] = generateUuid();
                    newObject["properties"] = validateArgTypes(elem)
                    objList.set(newObject["uuid"], newObject);
                    updateObjectsList();
                    generateShader();
                break;
                case "unary-operators":
                    let uuid = objSelect.find(":selected").val();
                    if(objList.has(uuid)){
                        let name = elem["name"];
                        console.log(name)
                        let object = objList.get(uuid);
                        console.log("u"+name)
                        let operation = {};
                        operation["name"] = name;
                        operation["arguments"] = validateArgTypes(elem);
                        // If object has no operations, create the operations array
                        if(!object.hasOwnProperty("operations")){
                            object["operations"] = [];
                        }
                        // Push new Operation
                        object["operations"].push(operation)
                        // Update
                        objList.set(uuid,object);
                        console.log(objList)
                        updateObjectsList();
                        generateShader();
                    }
                break;
                case "binary-operators":
                    let uuid1 = objSelect1.find(":selected").val();
                    let uuid2 = objSelect2.find(":selected").val();
                    if(uuid1 === uuid2){
                        alert("You can't use a binary operation on the same object");
                        return;
                    }

                    if(objList.has(uuid1) && objList.has(uuid2) ){
                        let object1 = objList.get(uuid1);
                        let object2 = objList.get(uuid2);
                        let name = elem["name"];
                        let newObject = {}
                        // Each object has a user defined-name
                        newObject["name"] = nameInput.val();
                        // Give to the object a uuid
                        newObject["uuid"] = generateUuid();
                        newObject["subObjects"] = [];
                        newObject["subObjects"].push(object1);
                        newObject["subObjects"].push(object2);
                        newObject["binaryOperation"] = {};
                        newObject["binaryOperation"][name]= validateArgTypes(elem);
                        objList.set(newObject["uuid"], newObject);
                        objList.delete(uuid1);
                        objList.delete(uuid2);
                        updateObjectsList();
                        generateShader();
                    }

                break;
            }
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

    function validateArgTypes(elem){
        let args = elem["arguments"];
        let finalObject = {};
        // Validate each argument
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
                alert("The values you entered were incorrect");
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
                validArguments[i]= parseFloat(value).toFixed(app.floatPrecision);
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

        for (const [key, value] of objList.entries()){
            obj = value;
            let li = document.createElement("li");
            li.setAttribute("id","obj-"+obj["uuid"]);

            let objName = document.createElement("span");
            objName.appendChild(document.createTextNode(obj["name"]));

            let deleteLink = document.createElement("a");
            deleteLink.setAttribute("href","#");

            $(deleteLink).click(function(){
                if (confirm("Are you sure you want to delete the objet")) {
                    let parent = this.parentNode;
                    if (parent) {
                        let parentId = parent["id"];
                        let objectId = parentId.split(/-(.+)/)[1];
                        console.log(objectId)
                        if (typeof objectId !== undefined && objectId != "") {
                            app["objects"].delete(objectId);
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
            console.log(objList);
        }
    }

    function generateUuid() {
        var S4 = function() {
           return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
        };
        return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
    }

    function generateShader(){
        let objList = app["objects"];
        let objUuIDList = [];
        let objListDeclaration = [];
        let objListDefinition = [];
        objList.forEach(function(obj, key, map){
            let cleanUuID = "obj"+obj.uuid.replace(/-/g,'');
            objUuIDList.push(cleanUuID);
            objListDeclaration.push("float "+cleanUuID+";");
            functionDistance = createObjectDistanceFunction(obj);
            objListDefinition.push(functionDistance["objectDistFunc"]);
        })
        let shader = defineConstants();
        shader+=definePrimitives();
        shader+="\n"+objListDeclaration.join("\n")+"\n\n";
        //Scene
        shader+=defineScene(objUuIDList,objListDefinition);
        //Raymarching function
        shader+= rayMarching();
        shader+= rayDirection();
        shader+= estimateNormal();
        shader+= phongContribForLight();
        shader+= phongIllumination();
        shader+= viewMatrix();
        shader+= mainShader();
        console.log(shader);
        Module.UpdateFragmentShader(shader);
        return shader;
    }

    function defineScene(objUuIDList, objListDefinition){
        let sceneFunc = "float sceneSDF(vec3 p) {\n";
        sceneFunc+=objListDefinition.join("\n");

        if(objUuIDList.length == 1){
            sceneFunc+="    return "+objUuIDList[0]+";\n";
        }
        else {
            let minmin;
            for(let i=0; i< objUuIDList.length; i++ ){
                if(i==1){
                    minmin= "min("+objUuIDList[0]+","+objUuIDList[1]+")";
                } else{
                    minmin="min("+minmin+","+objUuIDList[i]+")";
                }
            }

            sceneFunc+="    return "+minmin+";";
        }
        
        sceneFunc+="}\n";
        return sceneFunc;
    }

    function createObjectDistanceFunction(obj){
        let distanceFunctions = app["data"]["distance_functions"];
        let primitives = new Map();
        let objectDistFunc;
        if(obj.hasOwnProperty("binaryOperation")) {
            //Recursive call
        } else{
            let type = obj["originalType"];

            if(!primitives.has(type)){
                primitives.set(type, true);
                let cleanUuID = "obj"+obj.uuid.replace(/-/g,'');
                objectDistFunc = ""+cleanUuID+" = "+type+"(";
                let position = "p";
                let args;
                console.log(obj)
                if(obj.hasOwnProperty("operations")){
                    let uoperations = obj["operations"];
                    uoperations.forEach(function(uoperation){
                        console.log(uoperation)
                        switch(uoperation.name){
                            case "translation":
                                args = uoperation.arguments;
                                for (let [key, value] of Object.entries(args)) {
                                    position+="-"+argumentArrayToShaderStruct(value);
                                }
                            break;
                            
                            case "repetition":
                                args = uoperation.arguments;
                                let q;
                                for (let [key, value] of Object.entries(args)) {
                                    let c = argumentArrayToShaderStruct(value);
                                    position="mod("+position+","+c+") - 0.5*"+c;
                                    break;
                                }
                                break;
                        }
                    });
                }
                objectDistFunc+=position;
                Object.values(obj.properties).forEach(function(argument){
                    objectDistFunc += ",";
                    objectDistFunc += argumentArrayToShaderStruct(argument);
                });

                objectDistFunc+="); \n";
            }
        }

        return {"objectDistFunc" : objectDistFunc,"primitives" : primitives};
    }

    function argumentArrayToShaderStruct(argument){
        let shaderStruct = "";
        switch(argument.length){
            case 1:
                shaderStruct += argument[0];
                break;
            case 2:
                shaderStruct +="vec2("+argument.join(',')+")";
                break;
            case 3:
                shaderStruct +="vec3("+argument.join(',')+")";
                break;
            case 4:
                shaderStruct +="vec4("+argument.join(',')+")";
                break;
        }

        return shaderStruct;
    }

    function definePrimitives(){
        let distanceFunction = app["data"]["distance_functions"];
        let result = "\n";
        distanceFunction.forEach(function(fun){
            result+=fun["function"] + "\n";
        })
        return result;
    }

    function defineConstants(){
        return `
const int MAX_MARCHING_STEPS = 255;
const float MIN_DIST = 0.0;
const float MAX_DIST = 100.0;
const float EPSILON = 0.0001;`;
    }


    function rayMarching(){
        return `
float shortestDistanceToSurface(vec3 eye, vec3 marchingDirection, float start, float end) {
    float depth = start;
    for (int i = 0; i < MAX_MARCHING_STEPS; i++) {
        float dist = sceneSDF(eye + depth * marchingDirection);
        if (dist < EPSILON) {
            return depth;
        }
        depth += dist;
        if (depth >= end) {
            return end;
        }
    }
    return end;
}`;
    }

    function rayDirection(){
        return `
/**
 * Return the normalized direction to march in from the eye point for a single pixel.
 * 
 * fieldOfView: vertical field of view in degrees
 * size: resolution of the output image
 * fragCoord: the x,y coordinate of the pixel in the output image
 */
vec3 rayDirection(float fieldOfView, vec2 size, vec2 fragCoord) {
    vec2 xy = fragCoord - size / 2.0;
    float z = size.y / tan(radians(fieldOfView) / 2.0);
    return normalize(vec3(xy, -z));
}
        `; 
    }

    function estimateNormal(){
        return `
/**
 * Using the gradient of the SDF, estimate the normal on the surface at point p.
 */
vec3 estimateNormal(vec3 p) {
    return normalize(vec3(
        sceneSDF(vec3(p.x + EPSILON, p.y, p.z)) - sceneSDF(vec3(p.x - EPSILON, p.y, p.z)),
        sceneSDF(vec3(p.x, p.y + EPSILON, p.z)) - sceneSDF(vec3(p.x, p.y - EPSILON, p.z)),
        sceneSDF(vec3(p.x, p.y, p.z  + EPSILON)) - sceneSDF(vec3(p.x, p.y, p.z - EPSILON))
    ));
}
`;
    }

    function phongContribForLight(){
        return `
/**
 * Lighting contribution of a single point light source via Phong illumination.
 * 
 * The vec3 returned is the RGB color of the light's contribution.
 *
 * k_a: Ambient color
 * k_d: Diffuse color
 * k_s: Specular color
 * alpha: Shininess coefficient
 * p: position of point being lit
 * eye: the position of the camera
 * lightPos: the position of the light
 * lightIntensity: color/intensity of the light
 *
 * See https://en.wikipedia.org/wiki/Phong_reflection_model#Description
 */
vec3 phongContribForLight(vec3 k_d, vec3 k_s, float alpha, vec3 p, vec3 eye,
                            vec3 lightPos, vec3 lightIntensity) {
    vec3 N = estimateNormal(p);
    vec3 L = normalize(lightPos - p);
    vec3 V = normalize(eye - p);
    vec3 R = normalize(reflect(-L, N));
    
    float dotLN = dot(L, N);
    float dotRV = dot(R, V);
    
    if (dotLN < 0.0) {
        // Light not visible from this point on the surface
        return vec3(0.0, 0.0, 0.0);
    } 
    
    if (dotRV < 0.0) {
        // Light reflection in opposite direction as viewer, apply only diffuse
        // component
        return lightIntensity * (k_d * dotLN);
    }
    return lightIntensity * (k_d * dotLN + k_s * pow(dotRV, alpha));
}        
        `;
    }

    function phongIllumination(){
        return `
/**
 * Lighting via Phong illumination.
 * 
 * The vec3 returned is the RGB color of that point after lighting is applied.
 * k_a: Ambient color
 * k_d: Diffuse color
 * k_s: Specular color
 * alpha: Shininess coefficient
 * p: position of point being lit
 * eye: the position of the camera
 *
 * See https://en.wikipedia.org/wiki/Phong_reflection_model#Description
 */
vec3 phongIllumination(vec3 k_a, vec3 k_d, vec3 k_s, float alpha, vec3 p, vec3 eye) {
    const vec3 ambientLight = 0.5 * vec3(1.0, 1.0, 1.0);
    vec3 color = ambientLight * k_a;
    
    vec3 light1Pos = vec3(4.0 * sin(iTime),
                            2.0,
                            4.0 * cos(iTime));
    vec3 light1Intensity = vec3(0.4, 0.4, 0.4);
    
    color += phongContribForLight(k_d, k_s, alpha, p, eye,
                                    light1Pos,
                                    light1Intensity);
    
    vec3 light2Pos = vec3(2.0 * sin(0.37 * iTime),
                            2.0 * cos(0.37 * iTime),
                            2.0);
    vec3 light2Intensity = vec3(0.4, 0.4, 0.4);
    
    color += phongContribForLight(k_d, k_s, alpha, p, eye,
                                    light2Pos,
                                    light2Intensity);    
    return color;
}
        `;
    }

    function viewMatrix(){
        return `
/**
 * Return a transform matrix that will transform a ray from view space
 * to world coordinates, given the eye point, the camera target, and an up vector.
 *
 * This assumes that the center of the camera is aligned with the negative z axis in
 * view space when calculating the ray marching direction. See rayDirection.
 */
mat4 viewMatrix(vec3 eye, vec3 center, vec3 up) {
    // Based on gluLookAt man page
    vec3 f = normalize(center - eye);
    vec3 s = normalize(cross(f, up));
    vec3 u = cross(s, f);
    return mat4(
        vec4(s, 0.0),
        vec4(u, 0.0),
        vec4(-f, 0.0),
        vec4(0.0, 0.0, 0.0, 1)
    );
}`;
    }
    function mainShader(){
 return `
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec3 viewDir = rayDirection(45.0, iResolution.xy, fragCoord);
    vec3 eye = vec3(0.0, 0.0, 10.0);
    
    mat4 viewToWorld = viewMatrix(eye, vec3(0.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0));
    
    vec3 worldDir = (viewToWorld * vec4(viewDir, 0.0)).xyz;
    
    float dist = shortestDistanceToSurface(eye, worldDir, MIN_DIST, MAX_DIST);
    
    if (dist > MAX_DIST - EPSILON) {
        // Didn't hit anything
        fragColor = vec4(0.0, 0.0, 0.0, 0.0);
		return;
    }
    
    // The closest point on the surface to the eyepoint along the view ray
    vec3 p = eye + dist * worldDir;
    
    vec3 K_a = vec3(0.2, 0.2, 0.2);
    vec3 K_d = vec3(0.7, 0.2, 0.2);
    vec3 K_s = vec3(1.0, 1.0, 1.0);
    float shininess = 10.0;
    
    vec3 color = phongIllumination(K_a, K_d, K_s, shininess, p, eye);
    
    fragColor = vec4(color, 1.0);
}`;
    }
})();
