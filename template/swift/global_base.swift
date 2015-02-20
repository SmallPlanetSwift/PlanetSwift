<%
FULL_NAME_CAPS = "_"..string.upper(this.namespace).."_"
FULL_NAME_CAMEL = capitalizedString(this.namespace)
%>
//
// Autogenerated by gaxb at <%= os.date("%I:%M:%S %p on %x") %>
//

import Foundation
import PlanetSwift

public class <%= FULL_NAME_CAMEL %> {

	public class func readFromFile(filepath: String, prepare: Bool = true) -> GaxbElement? {
		var error: NSError?
		if let xmlString = String(contentsOfFile: filepath, encoding: NSUTF8StringEncoding, error: &error) {
			return <%= FULL_NAME_CAMEL %>.readFromString(xmlString)
		}
		return nil
	}

	public class func readFromString(string: String, prepare: Bool = true) -> GaxbElement? {
		if let xmlData = <%= FULL_NAME_CAMEL %>.processExpressions(string).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
			var error: NSError?
			if let xmlDoc = AEXMLDocument(xmlData: xmlData, error: &error) {
				let parsedElement = <%= FULL_NAME_CAMEL %>.parseElement(xmlDoc.rootElement as AEXMLElement)
				if prepare {
					parsedElement?.visit() { $0.gaxbPrepare() }
				}
				return parsedElement
			}
		}
		return nil
	}

	public class func namespaceForElement(element: AEXMLElement) -> String {
		if let namespace = element.namespaceURI?.lastPathComponent {
			return namespace
		}
		return "<%= FULL_NAME_CAMEL %>"
	}

	public class func parseElement(element: AEXMLElement) -> GaxbElement? {
		let namespace = self.namespaceForElement(element)
		if let entity : GaxbElement = GaxbFactory.element(namespace, name:element.name) {
			for (attribute, value) in element.attributes {
				entity.setAttribute(value as String, key: attribute as String)
			}
			for child in element.children {
				if let subEntity = <%= FULL_NAME_CAMEL %>.parseElement(child) {
					entity.setElement(subEntity, key: child.name)
				}
			}
			return entity
		}
		return nil
	}

<%
	-- simpleType definitions, such as enums
	for k,v in pairs(schema.simpleTypes) do
		-- only include defintions from this schema's namespace
		if (isEnumForItem(v)) then
			if (schema.namespace == v.namespace) then

				gaxb_print("\tpublic enum "..v.name..": String {\n");

				local appinfo = gaxb_xpath(v.xml, "./XMLSchema:annotation/XMLSchema:appinfo");
				local enums = gaxb_xpath(v.xml, "./XMLSchema:restriction/XMLSchema:enumeration");

				if(appinfo ~= nil) then
					appinfo = appinfo[1].content;
				end

				if(appinfo == "ENUM" or appinfo == "NAMED_ENUM") then
					for k,v in pairs(enums) do
						gaxb_print("\t\tcase "..v.attributes.value.." = \""..v.attributes.value.."\"\n")
					end
				end
		--		if(appinfo == "ENUM_MASK") then
		--			local i = 1
		--			gaxb_print("\tpublic enum\n{\n")
		--			for k,v in pairs(enums) do
		--				gaxb_print("\t\t"..v.attributes.value.." = "..i..",\n")
		--				i = i * 2;
		--			end
		--			gaxb_print("\t};\n")
		--		end

				gaxb_print("\t}\n\n");
			end
		end
	end
%>}

@objc(<%= FULL_NAME_CAMEL %>GaxbFactory) public class <%= FULL_NAME_CAMEL %>GaxbFactory : GaxbFactory {
	public override func classWithName(name : String) -> GaxbElement? {
		switch name {<%
for k,v in pairs(schema.elements) do
	-- if not in the schema namespace, skip
	if (schema.namespace == v.namespace) then
		v.name = cleanedName(v.name);%>
		case "<%= v.name %>":
			return <%= v.name %>()<%
	end
end %>
		default:
			return nil
		}
	}
}


//+ (id) readFromData:(NSData *)data withParent:(id)p AndMemoryLite:(BOOL)memLite
//+ (id) readFromData:(NSData *)data withParent:(id)p
//+ (id) readFromData:(NSData *)data
//+ (id) readFromFile:(NSString *)path
//+ (id) readFromString:(NSString *)xml_string
//+ (id) readFromDataFast:(NSData *)data
//+ (id) readFromFileFast:(NSString *)path
//+ (id) readFromStringFast:(NSString *)xml_string
//+ (NSString *) writeToString:(id)object
//+ (NSString *) writeOriginalXMLToString:(id)object
//+ (void) write:(id)object toFile:(NSString *)path
//+ (NSData *) writeToData:(id)object
//- (id) initWithParent:(id)p AndMemoryLite:(BOOL)m
//static char * DecodeAllAmpersands(char * src)
//static void SetValue(NSObject * object, NSObject * childObject, const char * elementName, const char * className)
//static NSObject * CreateElementWithNamespace(TBXMLElement * element, const char * currentNamespace, NSMutableDictionary * namespaceMap, NSObject * parent)