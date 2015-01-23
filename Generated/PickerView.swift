//
// Autogenerated by gaxb at 02:36:57 PM on 01/22/15
//

public class PickerView: PickerViewBase {
    var picker = UIPickerView()
    //var pickerWrapper: PickerViewWrapper?
    
    public var delegate: UIPickerViewDelegate? {
        didSet {
            picker.delegate = delegate
        }
    }
    public var datasource: UIPickerViewDataSource? {
        didSet {
            picker.dataSource = datasource
        }
    }
    
    override public var view: UIView {
        get {
            return picker
        }
        set {
            if newValue is UIPickerView {
                picker = newValue as UIPickerView
            }
        }
    }
    
    public override func gaxbPrepare() {
        super.gaxbPrepare()
        
        //See below
        /*pickerWrapper = PickerViewWrapper(components: 2, rows: 2)
        
        picker.delegate = pickerWrapper
        picker.dataSource = pickerWrapper*/
    }
}

//Delegate / Datasource wrapper --> Not used, instead whatever Controller has access to the picker should set itself as the delegate / datasource
/*class PickerViewWrapper: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var pickerComponents: Int = 0
    var pickerRows: Int = 0
    
    convenience init(components: Int, rows: Int)
    {
        self.init()
        pickerComponents = components
        pickerRows = rows
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerComponents
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerRows
    }
    
    // returns width of column and height of row for each component.
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "Default"
    }
}*/