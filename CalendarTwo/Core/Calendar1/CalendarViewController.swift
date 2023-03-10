//
//  CalendarViewController.swift
//  CalendarTwo
//
//  Created by Samuel Fuentes Navarrete on 05/03/23.
//

import UIKit

struct CalData {
    var day: String
    var date: Date?
    var data: Any?
}

struct DayTwo {
  // 1
  var date: Date
  // 2
  let number: String
  // 3
  let isSelected: Bool
  // 4
  let isWithinDisplayedMonth: Bool
}

class CalendarViewController : UIViewController {
    

    var selectedDate = Date()
    var totalOfDaysDispalyMonth = [CalData]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        setCellsView()
//        setMonthView()
        setDaysOfPreviousMont()
        
        InitComponents()
        

    }
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarDateCollectionViewCell.self,forCellWithReuseIdentifier:          CalendarDateCollectionViewCell.cellReuseIdentifier)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .gray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action: #selector(goNextMonth), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(goPreviousMonth), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    @objc func goPreviousMonth(){
        selectedDate = selectedDate.minusMonth
//        setMonthView()
        setDaysOfPreviousMont()
       
    }
    
    @objc func goNextMonth(){
        selectedDate = selectedDate.plusMonth
//        setMonthView()
        setDaysOfPreviousMont()

    }
    

    override open var shouldAutorotate: Bool
    {
        return false
    }
    
    
    func InitComponents(){
        AddComponets()
        SetLayout()
    }
    
    func AddComponets(){
        view.addSubview(previousMonthButton)
        view.addSubview(monthLabel)
        view.addSubview(nextMonthButton)
        view.addSubview(collectionView)
    }
    
    
    func SetLayout(){
        
        NSLayoutConstraint.activate([
            
            previousMonthButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            previousMonthButton.trailingAnchor.constraint(equalTo: monthLabel.leadingAnchor, constant: -15),
            
            monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            monthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextMonthButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            nextMonthButton.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 15),
            
            
            collectionView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -28),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
            
            ])
    }
}


extension CalendarViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalOfDaysDispalyMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarDateCollectionViewCell.cellReuseIdentifier,
            for: indexPath) as! CalendarDateCollectionViewCell
        
        let data = totalOfDaysDispalyMonth[indexPath.item]
        cell.dayOfMonth.text = data.day
        if let date = data.date, Calendar.current.isDateInToday(date) {
            cell.backgroundColor = .blue
        } else {
            cell.dayOfMonth.textColor = .black
        }
        
    
        return cell
    }
    
   
    
}


extension CalendarViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = totalOfDaysDispalyMonth[indexPath.item]
        guard let date = data.date else { return }
        print(date.dayString)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.size.width / 7) - 1
        let height = (collectionView.frame.size.height / 6) - 1

        return CGSize(width: width, height: height)
    }
}




extension CalendarViewController {
    
    func setDaysOfPreviousMont()
    {

        totalOfDaysDispalyMonth.removeAll()

        let firstDayOfMonth = selectedDate.firstDayOfMonth
        let startingSpaces = firstDayOfMonth.weekDay
        let lastDayOfMonth =  selectedDate.lastDayInMonth

        let monthYear = selectedDate.monthString + " " + selectedDate.yearString

        var count: Int = 0

        var date = selectedDate.firstDayOfMonth
        for _ in 1 ... 42
        {
       
            if(count < startingSpaces)
            {
                let day = selectedDate.calendar.date(byAdding: .day, value: -startingSpaces, to: date)!

                let dayNumber = day.dayString
                
                totalOfDaysDispalyMonth.append(CalData(day: dayNumber))
                date = selectedDate.calendar.date(byAdding: .day, value: 1, to: date)!
                
            }
            
//            else if (firstDayOfMonth <= lastDayOfMonth)
//            {
//                let day = String(count - startingSpaces)
//                let strDate = day + " " + monthYear
//                totalOfDaysDispalyMonth.append(CalData(day: day, date: strDate.date))
//            }
            else
            {
                totalOfDaysDispalyMonth.append(CalData(day: ""))
            }
                        
            count += 1
            daysDisplayOfMonth()
        print(totalOfDaysDispalyMonth)
        }
        
        monthLabel.text = selectedDate.monthString + " " + selectedDate.yearString
        collectionView.reloadData()
    }
    
    func daysDisplayOfMonth(){
        var count: Int = 0

        let firstDayOfMonth = selectedDate.firstDayOfMonth
        let startingSpaces = firstDayOfMonth.weekDay
        let lastDayOfMonth =  selectedDate.lastDayInMonth

        let monthYear = selectedDate.monthString + " " + selectedDate.yearString
        
        if (firstDayOfMonth <= lastDayOfMonth)
        {
            var date = selectedDate.firstDayOfMonth
            date = selectedDate.calendar.date(byAdding: .day, value: 1, to: date)!
            let dayNumber = date.dayString
            let strDate = dayNumber + " " + monthYear
            totalOfDaysDispalyMonth.append(CalData(day: dayNumber, date: strDate.date))
        }
        count += 1
    }
    
    
//    func setMonthView()
//    {
//        totalOfDaysDispalyMonth.removeAll()
//
//        let daysInMonth = selectedDate.daysInMonth
//        let firstDayOfMonth = selectedDate.firstDayOfMonth
//        let startingSpaces = firstDayOfMonth.weekDay
//
//        var count: Int = 1
//
//        let monthYear = selectedDate.monthString + " " + selectedDate.yearString
//
//        while(count <= 42)
//        {
//            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
//            {
//                totalOfDaysDispalyMonth.append(CalData(day: ""))
//            }
//            else
//            {
//                let day = String(count - startingSpaces)
//                let strDate = day + " " + monthYear
//                totalOfDaysDispalyMonth.append(CalData(day: day, date: strDate.date))
//            }
//            count += 1
//        }
//
//        monthLabel.text = selectedDate.monthString + " " + selectedDate.yearString
//        collectionView.reloadData()
//    }
    
    
}
