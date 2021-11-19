//
//  ViewController.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 18/11/21.
//

import UIKit
import AVKit
import AVFoundation

class InstatMainViewController: BaseViewController {
    private let matchDataSource = MatchDataModel()
    private let videoDataSource = VideoModel()
    private var videos = Video() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var infoContainerView: UIView!
    
    @IBOutlet weak var firstTeamView: UIView!
    @IBOutlet weak var firstTeamLabel: UILabel!
    
    @IBOutlet weak var secondTeamView: UIView!
    @IBOutlet weak var secondTeamLabel: UILabel!
    
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var fullTeamNamesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchDataSource.delegate = self
        videoDataSource.delegate = self
        
        setupTopTabBar(tintColor: .label, barTintColor: .systemBackground, preferLargerTitle: true)
        setupView()
        setupTableView()
        
        requestMatchData()
        requestVideoUrls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func setupView() {
        infoContainerView.backgroundColor = .link.withAlphaComponent(0.2)
        infoContainerView.layer.cornerRadius = 8
        firstTeamView.isRounded = true
        firstTeamView.setBorder(color: .lightGray, strokeWidth: 2)
        secondTeamView.isRounded = true
        secondTeamView.setBorder(color: .lightGray, strokeWidth: 2)
        scoreView.layer.cornerRadius = 8
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.rowHeight = 82
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableFooterView = UIView(frame: frame)
        tableView.tableHeaderView = UIView(frame: frame)
    }
    
    func configure(data: MatchData) {
        firstTeamLabel.text = data.team1?.abbrev_rus
        secondTeamLabel.text = data.team2?.abbrev_rus
        
        let firstTeamScore = data.team1?.score ?? 0
        let seconTeamScore = data.team2?.score ?? 0
        scoreLabel.text = String(format: "%d : %d", firstTeamScore, seconTeamScore)
        
        let firstTeam = data.team1?.name_rus ?? ""
        let secondTeam = data.team2?.name_rus ?? ""
        fullTeamNamesLabel.text = String(format: "%@ - %@", firstTeam, secondTeam)
        
        if let matchDate = Util.stringToDate(dateString: data.date ?? "", format: Constant.API_DATE_FORMAT){
            dateLabel.text = Util.formatDate(date: matchDate, format: Constant.FULL_DATE_WITHOUT_SECONDS)
        }
        
        title =  data.tournament?.name_rus ?? ""
    }
    
    private func requestMatchData() {
        showProgress()
        matchDataSource.requestData(params: DataRequestParam(
            proc: Constant.MATCH_INFO,
            sportId: Constant.MatchInfo.sportId,
            matchId: Constant.MatchInfo.matchId)
        )
    }
    
    private func requestVideoUrls() {
        videoDataSource.requestVideos(
            sportId: Constant.MatchInfo.sportId,
            matchId: Constant.MatchInfo.matchId
        )
    }
    
    func playVideo(url: String, tryAnother: Bool = false) {
        let videoUrl = URL(string: url)
        let player = AVPlayer(url: videoUrl!)
        
        if tryAnother {
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        } else {
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
        }
    }
}

extension InstatMainViewController: MatchDataModelDelegate {
    func didReceiveData(data: MatchData) {
        DispatchQueue.main.async {
            self.configure(data: data)
        }
        
    }
    
    func didReceiverError(error: Error) {
        DispatchQueue.main.async {
            self.dismissProgress()
            print("Error: \(error.localizedDescription)")
        }
    }
}

extension InstatMainViewController: VideoModelDelegate {
    func didReceiveVideos(videos: Video) {
        DispatchQueue.main.async {
            self.dismissProgress()
            self.videos = videos
        }
    }
    
    func didReceiveError(error: Error) {
        DispatchQueue.main.async {
            self.dismissProgress()
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
}


extension InstatMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoCell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        videoCell.videoNameLabel.text = videos[indexPath.row].name
        return videoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playVideo(url: videos[indexPath.row].url ?? "", tryAnother: true)
        print(indexPath.row)
    }
}

