//
//  NewTaskViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 26.03.2021.
//

import UIKit
import Combine

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView! 
    @IBOutlet weak var containerViewBottomConstrain: NSLayoutConstraint!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    private var subscribers = Set<AnyCancellable>()
    @Published private var taskString: String?
    
    weak var delegate: TasksVCDelegate?
    
    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        observeForm()
        setupGesture()
        observeKeyboard()
    }
    
    private func observeForm() { // настройка кнопки save . Поки тексту нема кнопка буде сірою
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).map({
            ($0.object as? UITextField)?.text
        }).sink { [unowned self] (text) in
            self.taskString = text
        }.store(in: &subscribers)
        
        $taskString.sink { [unowned self] (text) in
            self.saveButton.isEnabled = text?.isEmpty == false
        }.store(in: &subscribers)
    }
    
    
    override func viewDidAppear(_ animated: Bool) { //анмація відкривання taskTextField
        super.viewDidAppear(animated)
        taskTextField.becomeFirstResponder()
    }
    
    private func setupView() {
        backgroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.4)
        containerViewBottomConstrain.constant = -containerView.frame.height
    }
    
    private func setupGesture() { // функція для нажимання на екран щоб пропав контроллер
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapGestures.delegate = self
        view.addGestureRecognizer(tapGestures)
        
    }
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification ) { // в цій функції зробив щоб зайве місце в контейнері займала клавіатура
        let keyboardHeight = getKeyboardHeight(notification: notification)
        //анімація клавіатури ...
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.75 ,  initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [unowned self]
            in
            self.containerViewBottomConstrain.constant =  keyboardHeight - (200 +  8)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification ) {
        
        
        containerViewBottomConstrain.constant =  -containerView.frame.height
        
    }
    
    
    
    private func getKeyboardHeight (notification: Notification) -> CGFloat  {  // розмір клавіатури
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {return 0}
        return keyboardHeight
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
        
    }
    
    private func showCalendar() { /// розташування календаря
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
        taskTextField.resignFirstResponder()
        showCalendar()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskString = self.taskString else {return}
        let task = Task(title: taskString)
        delegate?.didAddTask(task)
    }
}

extension NewTaskViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if calendarView.isDescendant(of: view){
            return false
        }
        return true
        
    }
}
