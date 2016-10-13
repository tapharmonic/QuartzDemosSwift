//
//  MIT License
//
//  Copyright (c) 2016 TapHarmonic, LLC http://tapharmonic.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  This project was written by Bob McCune -- http://bobmccune.com
//

import UIKit

class QuartzDemosTableViewController: UITableViewController {

    var demos = [[String: [QuartzDemo]]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Quartz Demos"

        if let path = Bundle.main.path(forResource: "QuartzDemos", ofType: "plist") {
            for data in NSArray(contentsOfFile: path) as! [[String: [[String: String]]]] {
                if let group = data.keys.first {
                    var quartzDemos = [QuartzDemo]()
                    for demo in data[group]! {
                        if let title = demo["title"], let viewName = demo["viewName"] {
                            quartzDemos.append(QuartzDemo(title: title, viewName: viewName))
                        }
                    }
                    demos.append([group: quartzDemos])
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return demos[section].keys.first
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return demos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valuesForSection(section: section).count
    }

    func valuesForSection(section: Int) -> [QuartzDemo] {
        let dictionary = demos[section]
        if let key = dictionary.keys.first {
            return dictionary[key]!
        }
        return []
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
            cell?.accessoryType = .disclosureIndicator
        }

        let values = valuesForSection(section: indexPath.section)
        cell?.textLabel?.text = values[indexPath.row].title
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let values = valuesForSection(section: indexPath.section)
        let demo = values[indexPath.row]

        let controller: UIViewController
        if let clazz = demo.controllerClass as? NSObject.Type {
            print(clazz)
            controller = clazz.init() as! UIViewController
        } else {
            controller = QuartzViewController(viewClass: demo.viewClass!)
        }

        controller.title = demo.title
        navigationController?.pushViewController(controller, animated: true)
    }

}
