//
//  NotesViewController.swift
//  HW4
//
//  Created by qqtati on 22.11.2022.
//

import UIKit
protocol AddNoteDelegate{
    func newNoteAdded(note: ShortNote)
}
protocol TextViewDidChanged {
    func textViewDidChanged(_ textView: UITextView)
}
final class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    public var dataSource = [ShortNote]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    private func setupView() {
        setupTableView()
        setupNavBar()
        do {
            
            let jsonDecoder = JSONDecoder()
            guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileURL = path.appendingPathComponent("Output.json")
            let file = try Data(contentsOf: fileURL)
            let data = try! jsonDecoder.decode([ShortNote].self, from: file)
            dataSource = data
        } catch {
            print(error.localizedDescription)
        }
    }
    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier:
                            NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier:
                            AddNoteCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.pin(to: self.view, [.left: 12, .top: 12, .right:
                                        12, .bottom: 12])
    }
    private func setupNavBar() {
        self.title = "Notes"
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController(_:)),
                              for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:
                                                                    closeButton)
    }
    @objc
    private func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true)
    }
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let json = try jsonEncoder.encode(dataSource)
            let jsonString = String(data: json, encoding: .utf8)
            JSONEncoder.saveToDocumentDirectory(jsonString)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier:
                                                                AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
                                                                NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                   indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (indexPath.section != 1){
            return nil
        }
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (_, _, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        if (note.text == "") {
            return;
        }
        do {
            dataSource.insert(note, at: 0)
            tableView.reloadData()
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let json = try jsonEncoder.encode(dataSource)
            let jsonString = String(data: json, encoding: .utf8)
            JSONEncoder.saveToDocumentDirectory(jsonString)
        } catch {
            print(error.localizedDescription)
        }
    }
}
extension AddNoteCell: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        addButton.isEnabled = !textView.text.isEmpty
        addButton.alpha = addButton.isEnabled ? 0.8 : 0.5
    }
}
struct ShortNote : Codable{
    var text: String
}
extension JSONEncoder {
    public static func encode<T: Encodable>(from data: T) {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let json = try jsonEncoder.encode(data)
            let jsonString = String(data: json, encoding: .utf8)
            saveToDocumentDirectory(jsonString)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public static func saveToDocumentDirectory(_ jsonString: String?) {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = path.appendingPathComponent("Output.json")
        
        do {
            try jsonString?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
