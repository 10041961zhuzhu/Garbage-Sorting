//
//  ChannelTableVC.swift
//  Garbage Sorting
//
//  Created by 朱禹陶 on 28/03/2022.
//

import UIKit
import XLPagerTabStrip

class ChannelTableVC: UITableViewController {

    var channel = ""
    var subChannels: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subChannels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)

        cell.textLabel?.text = "# \(subChannels[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 15)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC = parent as! ChannelVC
        channelVC.PVDelegate?.updateChannel(channel: channel, subChannel: subChannels[indexPath.row])
        dismiss(animated: true)
        
    }

}

extension ChannelTableVC: IndicatorInfoProvider{
func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    IndicatorInfo(title: channel)
}
}
